import 'dart:developer';

import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:salonsync/Screens/login_page.dart';
// import 'package:flutter/foundation.dart';
import 'package:salonsync/constants.dart';
import 'package:salonsync/controller/Auth/Auth_method.dart';
import 'package:salonsync/controller/utility_controller.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();



userSignup({
    required String name,
    required String email,
    required String password,
    required String address,
    required String phone,
    required BuildContext context,
    // required Uint8List profileImage,
  }) async {
    print("called upper function");
    _controller.isLoading.value = true;
    String res = await AuthMethod().signUpUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address: _address.text,
      phone: _phoneController.text,
      isSalon: false,
      // profileImage: profileImage,
    );
    log(res.toLowerCase());
    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup Successful"),
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup Failed"),
        ),
      );
    }
    _controller.isLoading.value = false;
  }
  final UtilityController _controller=Get.put(UtilityController());
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text(
        "Register",
        style: TextStyle( fontSize: 30, fontFamily: 'Lato'),
      ),
      centerTitle: true,
      elevation: 0,
     
     
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [

Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/signup.png',
                  ),
                )),
              ),
            ),

              Padding(

                padding: const EdgeInsets.all(12.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                          controller: _nameController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter Full Name'),
                              MinLengthValidator(3,
                                  errorText: 'Minimum 3 charecter filled name'),
                            ]),
              
                            decoration: InputDecoration(
                                hintText: 'Enter Full Name',
                                labelText: 'full name',
                                prefixIcon: Icon(
                                  Icons.person,
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
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                          controller: _address,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Address'),
                              MinLengthValidator(3,
                                  errorText: 'Minimum 3 charecter filled name'),
                            ]),
              
                            decoration: InputDecoration(
                                hintText: 'Address',
                                labelText: 'Address',
                                prefixIcon: Icon(
                                  Icons.pin_drop_outlined,
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
                            controller: _phoneController,
                          
                            decoration: InputDecoration(
                                hintText: 'Mobile',
                                labelText: 'Mobile',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: themeColor,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _controller.isObscure.value,
                           
                            decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed:(){
                                _controller.toggleObscure();
                              },icon:  _controller.isObscure.value?const Icon(Icons.visibility):Icon(Icons.visibility_off),),
                  
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
                                'Register',
                                style: TextStyle(color: themeColor, fontSize: 22),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  userSignup(address:_address.text,context: context,email: _emailController.text,name:_nameController.text ,password: _passwordController.text,phone: _phoneController.text );
                                                    
                                }
                              },
                            ),
                          ),
                        )),
                        Center(
                    child: TextButton(

                      child: Text('Already have an Account, Login up',style: TextStyle(fontSize: 18),),
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  )
                          
                      
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
