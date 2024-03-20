import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salonsync/Screens/home.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/models/Salon_model.dart';
import 'package:salonsync/models/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProvider extends ChangeNotifier{
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    
  
  bool isLoading = false;
  var appointmentList = <Appointment>[];
  var salonLists = <Salon>[];
  var allSlots=<TimeSlot>[];
  bool isSerivceSelected=false;
  bool isSlotSelected=false;
  String selectedService='';
  DateTime? selectedSlot;
  int servicePrice=0;
 
  void selectCatalougeService(
    String serviceName,
    int price
  ){
selectedService=serviceName;
servicePrice=price;
isSerivceSelected=true;

 notifyListeners();

  }

 
  void selectSlot(
    DateTime startingTime
  ){
selectedSlot=startingTime;
isSlotSelected=true;
 notifyListeners();

  }
  // / This methof [getAppointment] is used to get all the appointments of the patient
  // / from the server.
  /// It takes the [token] as a parameter and returns the [AllAppointment] list.
  /// It also notifies the [ChangeNotifier] that the data is changed.
  /// It also sets the [isLoading] to false.



// Geting appointment of a user
  void getAllAppointment(context) async {

    isLoading = true;
    log("getting all apointments.....");
    
    var appointments = await fetchAppointment(context);
    if (appointments != null) {
      appointmentList = appointments as List<Appointment>;
       isLoading = false;
    }
      isLoading = false;
      log(appointmentList.toString());
          log("this is all apointments.....");

    
    notifyListeners();
  }
Future<List?> fetchAppointment(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var token = prefs.getString("uuid");

  try {
    if(token!=null){

      UserDetails user = UserDetails.fromSnap(await _fireStore
              .collection("Users")
              .doc(token)
              .get());
              // log(user.email);
              // log(user.phoneNumber);
              return user.appointments;
            //  return (user.Appointments);

    }
  
  }on FirebaseException{
    socketExceptionDialog(context);
  } 
  on SocketException {
    socketExceptionDialog(context);
  } on Exception catch (e) {
    errorDialog(context, e);
  }
  return null;
}


void getSalons(context) async {

    isLoading = true;
 log("calling salons.....");
    
    var salons = await fetchSalon(context);
    if (salons != null) {
      salonLists = salons as List<Salon>;
      
       isLoading = false;

    }
      isLoading = false;
      log(salonLists.toString());
          log("this is all apointments.....");

    
    notifyListeners();
  }
// Future<List?> fetchSalon(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString("uuid");
// final CollectionReference salonCollection =
//       FirebaseFirestore.instance.collection('Salon');
//        List<Salon> salons = [];

//   try {
   
// log("is this being called");
//   QuerySnapshot querySnapshot = await salonCollection.get();

//       querySnapshot.docs.forEach((doc) {
//         Salon salon = Salon.fromMap(doc.data());
//         salons.add(salon);

           

  
//   }on FirebaseException{
//     socketExceptionDialog(context);
//   } 
//   on SocketException {
//     socketExceptionDialog(context);
//   } on Exception catch (e) {
//     errorDialog(context, e);
//   } catch (e) {
//       print("Error fetching salons: $e");
//     }
//   return salons;
// }
 Future<List<Salon>> fetchSalon(context) async {
    List<Salon> salons = [];
final CollectionReference salonCollection =
      FirebaseFirestore.instance.collection('Salon');

    try {
      QuerySnapshot querySnapshot = await salonCollection.get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          Salon salon = Salon.fromMap(data);
          salons.add(salon);
        } else {
          print('Document data is null for document ID: ${doc.id}');
        }
      });
    } catch (e) {
      print("Error fetching salons: $e");
    }

    return salons;
  }

Future<void> addAppointment(

  serive,slot,salon,payment,status,salonUid,context
)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString("uuid");
log("THis shit is uid:"+ uid!);
final String documentId = uid!; // Replace with actual ID
final docRef =  FirebaseFirestore.instance.collection('Users').doc(documentId);
final newMap = {
'Service':selectedService,
'Salon':salon,
'Payement':payment,
'Status':status,
'Date time':selectedSlot,
};
try{
await docRef.update({
  'Appointments': FieldValue.arrayUnion([newMap]),
});
// final formattedDate = DateFormat('yyyy-MM-dd').format(selectedSlot!);
//   final docRefSalon = FirebaseFirestore.instance
//       .collection('salons')
//       .doc(salonUid)
//       .collection('slots')
//       .doc(formattedDate)
//       .collection('slotTimes')
//       .doc(DateFormat('HH:mm').format(slot.startTime));
//   await docRefSalon.set({'booked': true});
//   slot.isOccupied = true; // Update l
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data updated successfully!'),
      ),
    );
getAllAppointment(context);
}on FirebaseException{
    socketExceptionDialog(context);
  } 
  on SocketException {
    socketExceptionDialog(context);
  } on Exception catch (e) {
    errorDialog(context, e);
  }
  // void bookSlot(TimeSlot slot) async {
//   final formattedDate = DateFormat('yyyy-MM-dd').format(slot.startTime);
//   final docRef = FirebaseFirestore.instance
//       .collection('salons')
//       .doc(ownerId)
//       .collection('slots')
//       .doc(formattedDate)
//       .collection('slotTimes')
//       .doc(DateFormat('HH:mm').format(slot.startTime));
//   await docRef.set({'booked': true});
//   slot.isOccupied = true; // Update local state
// }


}

// Future<void> addAppointment(Appointment appointment, DocumentReference userRef) async {
//   // Add appointment data to the user's "appointments" subcollection
//   final appointmentDoc = await userRef.collection('appointments').add(appointment.toMap());
// }
 

// Get time Slots




// Dialog BOX
Future<dynamic> socketExceptionDialog(context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      titleTextStyle:  TextStyle(
        fontSize: 20,
        color: themeColor,
      ),
      title: const Text("No Internet Connection"),
      content:
          const Text("Please check your internet connection and try again"),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: themeColor, shadowColor: themeColor,
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop(
              context,
            );

            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

Future<dynamic> errorDialog(context, Exception e) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      titleTextStyle:  TextStyle(
        fontSize: 20,
        color: themeColor,
      ),
      title: const Text("Error"),
      content: Text("$e"),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: themeColor, shadowColor: themeColor,
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
          child: const Text("Ok"),
          onPressed: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pop(
            context,
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> loadingDialog(String title, BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
             CircularProgressIndicator(
              color: themeColor,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(title),
            ),
          ],
        ),
      );
    },
  );
}




}