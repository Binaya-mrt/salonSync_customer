import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:salonsync/Screens/signup.dart';
import 'package:salonsync/buttom_appbar.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/Auth/Auth_method.dart';
import 'package:salonsync/controller/utility_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final UtilityController _controller = Get.put(UtilityController());
bool isObsecure=true;
  userLogin({
    required String email,
    required String password,
    required BuildContext context,
    // required Uint8List profileImage,
  }) async {
    _controller.isLoading.value = true;
    String res = await AuthMethod().loginUser(
      email: email,
      password: password,
      isSalon: false,
      context: context
      // profileImage: profileImage,
    );

    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
        ),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const DefaultPage(
                pageno: 0,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup Failed"),
        ),
      );
    }
    _controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        "SalonSync",
        style: TextStyle( fontSize: 30, fontFamily: 'Lato'),
      ),
      centerTitle: true,
      elevation: 0,
     
     
      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login.png',
                  ),
                )),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter email address'),
                        EmailValidator(
                            errorText: 'Please correct email filled'),
                      ]),
                      decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: themeColor,
                          ),
                          errorStyle: const TextStyle(fontSize: 18.0),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText:isObsecure,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                             setState(() {
                               isObsecure=!isObsecure;
                             });
                            },
                            icon: isObsecure
                                ? const Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.password,
                            color: themeColor,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)))),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(color: themeColor, fontSize: 22),
                        ),
                        onPressed: () {
                         
                          if (_formkey.currentState!.validate()) {
                            userLogin(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                    ),
                  )),
                  Center(
                    child: TextButton(

                      child: Text('Not a user, Sign up',style: TextStyle(fontSize: 18),),
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
