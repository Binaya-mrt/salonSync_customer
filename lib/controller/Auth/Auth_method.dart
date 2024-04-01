// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:salonsync/constants.dart';
import 'package:salonsync/screens/login_page.dart';
import 'package:salonsync/models/user_model.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _auth.signOut();
    // Optionally navigate to the login screen after successful logout
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return const LoginPage();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
    prefs.remove("uuid");
    prefs.remove("name");
  }

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String address,
    required String phone,
    required bool isSalon,
  }) async {
    String res = "Some error occured";

    try {
      // this will only signup a user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // We also need to store bio and username in firestore
      // (_fireStrore.collection("users").doc(cred.user!.uid));

      await _fireStore
          .collection(
            "Users",
          )
          .doc(cred.user!.uid)
          .set({
        "email": email,
        "name": name,
        "address": address,
        "phone": phone,
        "uid": cred.user!.uid,
        "isSalon": isSalon,
       
      });
      res = "success";
    } on FirebaseAuthException catch (err) {
      res = err.message.toString();

    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// SignIN **************
  Future<String> loginUser(
      {required String email,
      required String password,
      required bool isSalon,
      context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String res = "Some error occured";

    try {
      if ((isSalon == false) && email.isNotEmpty || password.isNotEmpty) {
        // this will only Login a user
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(cred.user!.uid)
            .get();

        res = snapshot.exists ? "success" : "something went wrong";

        if (res == "success") {
          UserDetails user = UserDetails.fromSnap(
              await _fireStore.collection("Users").doc(cred.user!.uid).get());
          log(user.email);
          prefs.setString("uuid", cred.user!.uid);
          prefs.setString("name", user.name);
          prefs.setBool("first_time", true);
        }
      } else {
        res = "Please enter email and password";
      }
    } on FirebaseAuthException catch (err) {
      Utils().showSnackBar(context, err.message.toString());

      res = err.message.toString();
      debugPrint(err.message);
    } on SocketException catch (err) {
      Utils().showSnackBar(context, err.message.toString());
      res = err.toString();
    } catch (err) {
      Utils().showSnackBar(context, err.toString());

      res = err.toString();
    }
    return res;
  }
}
