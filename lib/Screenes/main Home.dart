import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:socialapp2/main.dart';

import '../Cubit/mainHome Cubit/main_home_cubit.dart';
import '../Widgets/CustomeAppBar.dart';
import '../Widgets/ImageState.dart';

import '../Widgets/postState.dart';
import '../Widgets/saveImageState.dart';
import '../constanse.dart';
import 'LoginPage.dart';

CollectionReference backgroundimage =
    FirebaseFirestore.instance.collection('backgroundimage');

class MainHome extends StatelessWidget {
  MainHome({super.key});

  var rand, post;
  var imageposturl;
  bool islike = false;
  int likes = 0;
  String like = 'like';

  CollectionReference getuserslikes =
      FirebaseFirestore.instance.collection('userslikes');
  var url, url2, currentlist, name, file, imageurl, time, newtime;
  int index = 0;
  double h = Get.height;
  double w = Get.width;
  GlobalKey<FormState> changenameform = new GlobalKey<FormState>();
  TextEditingController mind = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainHomeCubit(),
      child: BlocConsumer<MainHomeCubit, MainHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              drawer: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.blueGrey),
                height: h - 80,
                width: w - 150,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: w - 170,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              Get.isDarkMode == true
                                  ? '   Dark mood'
                                  : '   Ligth mood',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'NotoSerif',
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10),
                      width: w - 170,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => saveImageState());
                        },
                        child: Text(
                          'Saved',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
         /*
                    InkWell(
                      onTap: () {
                        Get.bottomSheet((Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'update your name !',
                              ),
                              validator: (val) {
                                if (val == '') {
                                  return 'Required field';
                                }
                              },
                              onFieldSubmitted: (val) async {
                               await name!.remove('name');
                               await   name!.setString('name', '$val');
                              },
                              key: changenameform,
                            ),
                          ),
                        )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: w - 170,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        child: Center(
                          child: Text(
                            'Change user name',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
          */
                  ],
                ),
              ),
              backgroundColor: Colors.blueGrey,
              appBar: AppBar(
                backgroundColor: Colors.black45,
                actions: [
                  IconButton(
                      onPressed: () async {
                        AwesomeDialog(
                                context: context,
                                body: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Are you sure to sign out?',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              fontFamily: 'NotoSerif',
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 70,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.red),
                                          child: InkWell(
                                            child: Center(
                                              child: Text(
                                                'yes',
                                                style: TextStyle(
                                                    fontFamily: 'NotoSerif',
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            onTap: () async {
                                              await FirebaseAuth.instance
                                                  .signOut();
                                              Get.to(() => LoginPage());
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Container(
                                          width: 80,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue),
                                          child: InkWell(
                                            child: Center(
                                              child: Text(
                                                'cancel',
                                                style: TextStyle(
                                                    fontFamily: 'NotoSerif',
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            onTap: () {
                                              Get.back();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                dialogType: DialogType.warning)
                            .show();
                      },
                      icon: Icon(Icons.power_settings_new))
                ],
                title: Text(
                  'Social App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'NotoSerif'),
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        CustomeAppBar(),
                        StreamBuilder(
                            stream: userPostes
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => snapshot
                                                .data!.docs[index]
                                                .get('postState') ==
                                            'post'
                                        ? PostState(
                                            index: index,
                                            snapshot: snapshot,
                                          )
                                        : ImageState(
                                            snapshot: snapshot, index: index),
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: snapshot.data!.docs.length);
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ])))
/*    : Center(
                  child: Text('No Postes avalible',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'NotoSerif',
                        fontWeight: FontWeight.w500),),
                ),*/

              );
        },
      ),
    );
  }
}
