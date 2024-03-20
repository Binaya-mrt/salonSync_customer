import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salonsync/Screens/notification.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/Auth/Fetch_Appointments.dart';

class Appointment extends StatelessWidget {
  Appointment({super.key});
// DateFormat dateFormat = DateFormat();

  @override
  Widget build(BuildContext context) {
    // var _appointment = Provider.of<ListProvider>(context, listen: false);
    // _appointment.getAllAppointment(context);

   
    return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Consumer<ListProvider>(builder: (context, appointments, child) {
    //               return appointments.isLoading == true
    //                   ? const Center(
    //                       child: CircularProgressIndicator(),
    //                     )
    //                   : appointments.appointmentList.isEmpty
    //                       ? const Text('No any appointments...')
    //                       :ListView.builder(
    //                         shrinkWrap: true,
    //   itemCount: appointments.appointmentList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Card(
    //       elevation: 2.0,
    //       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    //       child: ListTile(
    //         contentPadding: EdgeInsets.all(16.0),
    //         title: Text(
    //           appointments.appointmentList[index].salon,
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         subtitle: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text('Service: ${appointments.appointmentList[index].service}'),
    //             // Text('Date & Time: ${appointments[index].dateTime.toString()}'),
    //             Text('Status: ${appointments
    //                                                     .appointmentList[index]
    //                                                     .status}'),
    //             Text('Payment: ${appointments
    //                                             .appointmentList[index]
    //                                             .payment ? 'Paid' : 'Due'}'),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
    //                       // : ListView.builder(
    //                       //     shrinkWrap: true,
    //                       //     physics: const NeverScrollableScrollPhysics(),
    //                       //     itemCount: appointments.appointmentList.length,
    //                       //     itemBuilder: (BuildContext context, int index) {
    //                       //       return ListTile(
    //                       //         leading: CircleAvatar(
    //                       //           backgroundColor: appointments
    //                       //                       .appointmentList[index]
    //                       //                       .status ==
    //                       //                   "Pending"
    //                       //               ? Colors.amber
    //                       //               : appointments.appointmentList[index]
    //                       //                           .status ==
    //                       //                       "Appointed"
    //                       //                   ? Colors.green
    //                       //                   : Colors.grey,
    //                       //           child: Text(
    //                       //             appointments.appointmentList[index]
    //                       //                         .status ==
    //                       //                     "Pending"
    //                       //                 ? 'P'
    //                       //                 : appointments.appointmentList[index]
    //                       //                             .status ==
    //                       //                         "Appointed"
    //                       //                     ? "A"
    //                       //                     : "C",
    //                       //             style:
    //                       //                 const TextStyle(color: Colors.white),
    //                       //           ),
    //                       //         ),
    //                       //         title: Text(appointments
    //                       //             .appointmentList[index].salon),
    //                       //         subtitle: Text('dd/MM/yyyy - HH:mm'),
    //                       //         trailing: Row(
    //                       //           mainAxisSize: MainAxisSize
    //                       //               .min, // Constrain trailing widget width
    //                       //           children: [
    //                       //             Text(
    //                       //               appointments.appointmentList[index]
    //                       //                           .status ==
    //                       //                       "Pending"
    //                       //                   ? 'Pending'
    //                       //                   : appointments
    //                       //                               .appointmentList[index]
    //                       //                               .status ==
    //                       //                           "Appointed"
    //                       //                       ? "Appointed"
    //                       //                       : "Canceled",
    //                       //               style: TextStyle(color: themeColor),
    //                       //             ),
    //                       //             const SizedBox(
    //                       //                 width: 5.0), // Add a small spacer
    //                       //             Text(
    //                       //               appointments
    //                       //                   .appointmentList[index].payment?"Payment Done":"Payment Due",
    //                       //               style:  TextStyle(
    //                       //                   color: appointments
    //                       //                   .appointmentList[index].payment?Colors.green:Colors.red),
    //                       //             ),
    //                       //           ],
    //                       //         ),
    //                       //       );
    //                       //     },
    //                       //   );
    //             }),
    //           ],
            ),
        
        ));
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

}
