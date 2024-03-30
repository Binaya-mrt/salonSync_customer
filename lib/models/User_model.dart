// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  String? image;
  String? uid;
  List<Appointment>? appointments;

  UserDetails({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    this.image,
    this.uid,
    this.appointments,
  });
  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "email": email,
        "uid": uid,
        "phone_number": phoneNumber,
        "image": image,
        "appointments":
            List<Appointment>.from(appointments!.map((x) => x.toMap())),
      };

  static UserDetails fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    log(snapshot.toString());
    return UserDetails(
        email: snapshot['email'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        address: snapshot['address'],
        //
        appointments: snapshot['Appointments']
            .map((p) => Appointment.fromJson(p))
            .toList()
            .cast<Appointment>(),
        phoneNumber: snapshot['phone']
        // image: snapshot['image'],

        );
  }
}

class Appointment {
  final String service;

  final Timestamp datetime;

  final String salon;
  final bool payment;
  final String status;

  Appointment({
    required this.service,
    required this.datetime,
    required this.salon,
    required this.payment,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
        "service": service,
        "date": datetime,
        "salon": salon,
        "payment": payment,
        "status": status,
      };

  static Appointment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Appointment(
      service: snapshot['Service'],
      datetime: snapshot['Date time'],
      salon: snapshot['Salon'],
      status: snapshot['Status'],
      payment: snapshot['Payement'],

      //  name: snapshot['name'],
    );
  }

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      service: json['Service'],
      datetime: json['Date time'],
      salon: json['Salon'],
      payment: json['Payement'],
      status: json['Status']);
}
