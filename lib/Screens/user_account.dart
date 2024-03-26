import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salonsync/Screens/notification.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/Auth/Auth_method.dart';
import 'package:salonsync/controller/preferences_controller.dart';

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context),
      body: Padding(
        padding: EdgeInsets.only(top:20,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display user details using FutureBuilder
            FutureBuilder<User?>(
              future: FirebaseAuth.instance.authStateChanges().first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('User not signed in');
                } else {
                  final user = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Name: ${user.uid}',style: TextStyle(fontSize: 18),),
                      Text('Email: ${user.email}',style: TextStyle(fontSize: 24),),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            // Form to update password
            PasswordUpdateForm(),
            SizedBox(height: 20),
            // Logout button
            ElevatedButton(
              onPressed: () async {
               AuthMethod().logout(context);
              },
              child: Text('Logout',style: TextStyle(color: themeColor),),
            ),
          ],
        ),
      ),
    );
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

class PasswordUpdateForm extends StatefulWidget {
  @override
  _PasswordUpdateFormState createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool showPassword=false;
  
   void changeShowPassword(showPass){
    setState(() {
      
   showPassword=showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Update Password',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: themeColor,),
            ),
          ),
          TextFormField(
            controller: _oldPasswordController,
            obscureText: !showPassword,
            decoration: InputDecoration(labelText: 'Old Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your old password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _newPasswordController,
            obscureText: !showPassword,

            decoration: InputDecoration(labelText: 'New Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a new password';
              }
              return null;
            },
          ),
          
          CheckboxListTile(value: showPassword, onChanged:changeShowPassword,title: Text('Show Password'),controlAffinity: ListTileControlAffinity.leading,),
          SizedBox(height: 10),
          ElevatedButton(
            // style: ElevatedButton.styleFrom/,
            onPressed: ()async {
              if (_formKey.currentState!.validate()) {
                
               
_updatePassword(_oldPasswordController.text,_newPasswordController.text);
              }
            },
            child: Text('Update Password',style: TextStyle(color: themeColor),),
          ),
        ],
      ),
    );
  }
  void _updatePassword(String currentPassword, String newPassword) async {
final user = FirebaseAuth.instance.currentUser;
final cred = EmailAuthProvider.credential(
    email: user!.email!, password: currentPassword);

user.reauthenticateWithCredential(cred).then((value) {
  user.updatePassword(newPassword).then((_) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
      }).catchError((error) {
       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating password: $error')));
      });
}).catchError((err) {
 
});}

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
