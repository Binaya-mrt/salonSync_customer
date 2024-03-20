// ignore_for_file: unrelated_type_equality_checks


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';
import 'package:salonsync/Screens/login_page.dart';
import 'package:salonsync/Screens/on_boarding.dart';
// import 'package:salonsync/Screens/on_boarding.dart';
import 'package:salonsync/buttom_appbar.dart';
// import 'package:salonsync/controller/Auth/Fetch_Appointments.dart';
import 'package:salonsync/controller/preferences_controller.dart';
// import 'package:salonsync/buttom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// final SharedPreferences _firsttime=await SharedPreferences.getInstance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyAXZYuLRhj6cQPL1RCGjGbqc7HUJKFm_zA", // paste your api key here
      appId:
          "1:255426473244:android:f210080a1cebb68570ded9", //paste your app id here
      messagingSenderId: "255426473244", //paste your messagingSenderId here
      projectId: "salonsync-15e10", //paste your project id here
      storageBucket: "salonsync-15e10.appspot.com"
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // var name = prefs.getString('name');
  var uuid=prefs.getString('uuid');
  var first=prefs.getBool('first_user');
  
  PreferenceUtils.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato'),
      
      
      home: first==null
          ?  OnBoard()
          :uuid==null? const LoginPage()
          : const DefaultPage(
             pageno: 0,
            ),
    ),
  );
}

/* 

  
*/

