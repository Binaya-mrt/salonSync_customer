import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Appointment {
  final String customerId;
  final String salonId;
  final String serviceName;
  final int price;
  final bool payment;
  final String status;
  final DateTime appointmentDateTime;

  Appointment({
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
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day, parsedHour);
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

  Future<void> bookAppointment(Appointment appointment) async {
    try {
      await appointmentsCollection.add(appointment.toMap());
      log('Appointment booked successfully.');
    } catch (e) {
      log('Error booking appointment: $e');
    }
  }
  Future<bool> isSlotAvailable(
      String salonId, DateTime selectedDate, int slotStartTime) async {
        // log('olelele');
           try {
            log('olelele');
      // int slotEndTime = slotStartTime + 1; // Assuming each slot is one hour
      DateTime startTime = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, slotStartTime);
      Timestamp startDateTime=Timestamp.fromDate(startTime);
      

      // Query appointments that overlap with the selected slot
      QuerySnapshot querySnapshot = await appointmentsCollection
          .where('salonId', isEqualTo: salonId)
          .where('appointmentDateTime', isEqualTo: startDateTime)
          .get();

      // Check if there are any existing appointments in the selected slot
      log(querySnapshot.docs.isEmpty.toString()+" khai k khai k ");
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      debugPrint(' $e');
      return false;
    }
  }
}