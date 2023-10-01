
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:socialapp2/Screenes/singup.dart';


import '../Cubit/login_cubit.dart';
import 'main Home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool visibality = true;
  int x = 0;
  UserCredential? userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Get.to(() => MainHome());
          } else if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginFailed) {
            Get.defaultDialog(title: '${state.error}');
            isLoading = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(150))),
                    width: double.infinity,
                    height: 280,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 280.0),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      child: Form(
                          key: form,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                        'Login Page',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'NotoSerif'),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle:
                                        TextStyle(fontFamily: 'NotoSerif'),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                        )),
                                    controller: email,
                                    validator: (val) {
                                      if (val == '') {
                                        return 'Required field';
                                      }
                                      if (val!.contains('@gmail.com') ==
                                          false) {
                                        return 'This email is not recognized';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        labelText: 'Password',
                                        labelStyle:
                                        TextStyle(fontFamily: 'NotoSerif'),
                                        suffixIcon: IconButton(
                                          onPressed: () {
/*
                                          if (visibality == true) {
                                            setState(() {
                                              visibality = false;
                                            });
                                          } else {
                                            setState(() {
                                              visibality = true;
                                            });
                                          }
                             */
                                          },
                                          icon: visibality
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        )),
                                    obscureText: visibality,
                                    controller: pass,
                                    validator: (txt) {
                                      if (txt == '') {
                                        return 'Required field';
                                      }
                                      if (txt!.length < 8) {
                                        return 'The password cannot be less than 8 letters';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '- - - - - - - - - - -',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
    Get.to(() => singup());
                                        },
                                        child: Text(
                                          ' Sing Up ',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontFamily: 'NotoSerif'),
                                        ),
                                      ),
                                      Text(
                                        '- - - - - - - - - - -',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (form.currentState!.validate()) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .Login(
                                            email: email.text,
                                            pass: pass.text);
                                      }
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontFamily: 'NotoSerif'),
                                          )),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              40),
                                          color: Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 650.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius:
                          BorderRadius.only(topRight: Radius.circular(250))),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
