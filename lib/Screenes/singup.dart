import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../Cubit/signinCubit/sign_in_cubit.dart';
import '../Widgets/set Profile Pic.dart';
import '../main.dart';

class singup extends StatefulWidget {
  const singup({super.key});

  @override
  State<singup> createState() => _singupState();
}

class _singupState extends State<singup> {
  bool visibality = true;
  int x = 0;
  UserCredential? userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) async {
          if (state is SignInLoading) {
            isLoading = true;
          } else if (state is SignInFailed) {
            isLoading = true;
            Get.defaultDialog(title: '${state.error}');
            isLoading = false;
          } else {
            isLoading = true;
            await FirebaseFirestore.instance.collection('users').add({
              'email': '${email.text}',
              'password': '${pass.text}',
              'name': '${username.text}'
            });
            await name!.setString('name', '${username.text}');
            isLoading = false;
            Get.to(() => SetProfilePicture());
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
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Container(
                    width: double.infinity,
                    height: 430,
                    child: Form(
                        key: form,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                Center(
                                    child: Text(
                                  'Sing Up Page',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'NotoSerif',
                                  ),
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
                                    }),
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
                                          if (visibality == true) {
                                            setState(() {
                                              visibality = false;
                                            });
                                          } else {
                                            setState(() {
                                              visibality = true;
                                            });
                                          }
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintText: 'Enter your profile name',
                                    hintStyle:
                                        TextStyle(fontFamily: 'NotoSerif'),
                                  ),
                                  controller: username,
                                  validator: (txt) {
                                    if (txt!.length < 3) {
                                      return 'Sorry Profile Name Can`t be Less Than 3 Letter';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (form.currentState!.validate()) {
                                      BlocProvider.of<SignInCubit>(context)
                                          .SignIn(
                                              email: email.text,
                                              pass: pass.text);
                                    }
                                  },
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    child: Center(
                                        child: Text(
                                      'Sing Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontFamily: 'NotoSerif'),
                                    )),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
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
            )),
          );
        },
      ),
    );
  }
}
