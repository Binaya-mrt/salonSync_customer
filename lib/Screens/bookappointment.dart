// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salonsync/constants.dart';

class AppointmentModel {
  final String customerId;
  final String salonId;
  final String serviceName;
  final int price;
  final bool payment;
  final String status;
  final DateTime appointmentDateTime;

  AppointmentModel({
    required this.customerId,
    required this.salonId,
    required this.serviceName,
    required this.price,
    required this.payment,
    required this.status,
    required this.appointmentDateTime,
  });

  static DateTime convertToDate(String date, String hour) {
    DateTime parsedDate = DateTime.parse(date);
    int parsedHour = int.parse(hour.split(' ')[0]);
    if (hour.contains('PM') && parsedHour != 12) {
      parsedHour += 12;
    } else if (hour.contains('AM') && parsedHour == 12) {
      parsedHour = 0;
    }
    return DateTime(
        parsedDate.year, parsedDate.month, parsedDate.day, parsedHour);
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'salonId': salonId,
      'serviceName': serviceName,
      'price': price,
      'payment': payment,
      'status': status,
      'appointmentDateTime': Timestamp.fromDate(appointmentDateTime),
    };
  }
}

class AppointmentService {
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('Appointments');

  Future<void> bookAppointment(AppointmentModel appointment,context) async {
    try {
      await appointmentsCollection.add(appointment.toMap());
    
    } catch (e) {
       Utils().showSnackBar(context, e.toString());
      log('Error booking appointment: $e');
    }
  }

  Future<bool> isSlotAvailable(
      String salonId, DateTime selectedDate, int slotStartTime) async {
    try {
      DateTime startTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, slotStartTime);
          
      Timestamp startDateTime = Timestamp.fromDate(startTime);

      // Query appointments that overlap with the selected slot
      QuerySnapshot querySnapshot = await appointmentsCollection
          .where('salonId', isEqualTo: salonId)
          .where('appointmentDateTime', isEqualTo: startDateTime)
          .get();

      return querySnapshot.docs.isEmpty && !startTime.isBefore(DateTime.now());
    } catch (e) {
      
      return false;
    }
  }
}
