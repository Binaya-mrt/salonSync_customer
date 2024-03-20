

import 'package:flutter/material.dart';
import 'package:salonsync/controller/Auth/Auth_method.dart';

class UserAccount extends StatelessWidget {
   UserAccount({super.key});

final AuthMethod _auth=AuthMethod();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: ElevatedButton(onPressed: ()=>_auth.logout(context),
     child: Text('Logout')),),);
  }
}