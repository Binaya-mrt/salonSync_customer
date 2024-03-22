import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salonsync/Screens/notification.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/Auth/Fetch_Appointments.dart';
import 'package:salonsync/controller/preferences_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment extends StatefulWidget {
  Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
// DateFormat dateFormat = DateFormat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body:  FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Appointments')
            .where('customerId', isEqualTo: PreferenceUtils.getString('uuid'))
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No appointments found.'));
          } else {
            final appointments = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return AppointmentListItem(appointment: appointment);
              },
            );
          }
        },
      ),
    );
  }
  }

  // void _showBottomSheet(BuildContext context, DocumentSnapshot appointment) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Text('Appointment Details'),
  //             SizedBox(height: 16.0),
  //             Text('Title: ${appointment['serviceName']}'),
  //             Text('Status: ${appointment['status']}'),
  //             SizedBox(height: 16.0),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Perform cancel operation
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Cancel Appointment'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Perform update operation
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Update Appointment'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "SalonSync",
        style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor,
      leading: Container(
          margin: const EdgeInsets.all(14),
          child: const CircleAvatar(
            radius: 30,
          )),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()),
              );
            },
            icon: const Icon(
              Icons.notification_add_rounded,
              color: Colors.white,
              size: 30,
            ))
      ],
    );
  }
class AppointmentListItem extends StatelessWidget {
  final DocumentSnapshot appointment;

  const AppointmentListItem({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final salonId = appointment['salonId'];
    final serviceName = appointment['serviceName'];
    final status = appointment['status'];
    final price = appointment['price'];
    final appointmentDateTime = appointment['appointmentDateTime'];

    // Fetch salon details from Firestore using salon ID
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Salon')
          .doc(salonId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('Salon details not found');
        } else {
      final salonName = snapshot.data!['salon_name'];
Timestamp timestamp = appointmentDateTime;
DateTime dateTime = timestamp.toDate();
String formattedDateTime = DateFormat('yyyy-MM-dd h a').format(dateTime);
          return ListTile(
            title: Text(serviceName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salon: $salonName'),
                Text('Status: $status'),
                Text('Price: $price'),
                Text('Appointment Date: $formattedDateTime'),
              ],
            ),
            // Add additional styling or actions as needed
            // For example, you can add trailing icons for actions like cancel or update
          );
        }
      },
    );
  }
}