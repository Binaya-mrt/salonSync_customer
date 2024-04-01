// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/preferences_controller.dart';
import 'package:salonsync/screens/notification.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
// DateFormat dateFormat = DateFormat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Appointments')
            .where('customerId', isEqualTo: PreferenceUtils.getString('uuid'))
             // Order appointments by date
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          } else {
            final appointments = snapshot.data!.docs;

            // final appointments = snapshot.data!.docs;

  // Sort appointments by appointmentDateTime
  appointments.sort((a, b) {
    // Convert appointmentDateTime to DateTime objects
    DateTime dateTimeA = (a['appointmentDateTime'] as Timestamp).toDate();
    DateTime dateTimeB = (b['appointmentDateTime'] as Timestamp).toDate();
    // Compare appointmentDateTime
    return dateTimeB.compareTo(dateTimeA); // Sort in descending order
  });
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


AppBar appBar(BuildContext context) {
  return AppBar(
    title: const Text(
      "SalonSync",
      style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato'),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: bgColor,
    // leading: Container(
    //     margin: const EdgeInsets.all(14),
    //     child: const CircleAvatar(
    //       radius: 30,
    //     )),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
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

class AppointmentListItem extends StatefulWidget {
  final DocumentSnapshot appointment;

  const AppointmentListItem({super.key, required this.appointment});

  @override
  State<AppointmentListItem> createState() => _AppointmentListItemState();
}

class _AppointmentListItemState extends State<AppointmentListItem> {
  @override
  Widget build(BuildContext context) {
    final salonId = widget.appointment['salonId'];
    final serviceName = widget.appointment['serviceName'];
    final status = widget.appointment['status'];
    final price = widget.appointment['price'];
    final appointmentDateTime = widget.appointment['appointmentDateTime'];

    // Fetch salon details from Firestore using salon ID
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Salon').doc(salonId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('Salon details not found');
        } else {
           

    
          final salonName = snapshot.data!['salon_name'];
          Timestamp timestamp = appointmentDateTime;
          DateTime dateTime = timestamp.toDate();
          String formattedDateTime =
              DateFormat('yyyy-MM-dd h a').format(dateTime);
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: ListTile(
              trailing: widget.appointment['status'] == 'Pending'
                  ? IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: themeColor,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Cancel Appointment'),
                              content: const Text(
                                  'Are you sure you want to cancel this appointment?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await widget.appointment.reference
                                        .update({'status': 'Cancelled'});
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text('Yes, Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      })
                  : null,
              title: Text(serviceName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Salon: $salonName'),
                  Text(
                    'Status: $status',
                    style: TextStyle(
                        color: status == 'Pending'
                            ? Colors.lightGreen
                            : status == "Completed"
                                ? themeColor
                                : Colors.red),
                  ),
                  Text('Price: NPR $price'),
                  Text('Appointment Date: $formattedDateTime'),
                  widget.appointment['status'] == 'Pending'
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Cancel Appointment'),
                                  content: const Text(
                                      'Are you sure you want to cancel this appointment?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await widget.appointment.reference
                                            .update({'status': 'Cancelled'});
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: const Text('Yes, Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Cancel Appointment',
                            style: TextStyle(color: themeColor),
                          ))
                      : const SizedBox(),
                ],
              ),
              // Add additional styling or actions as needed
              // For example, you can add trailing icons for actions like cancel or update
            ),
          );
        }
      },
    );
  }
}
