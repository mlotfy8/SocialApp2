import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp2/Widgets/videoIconButton.dart';


import '../Cubit/get_fire_data_cubit.dart';
import '../Methodes/Loading.dart';
import '../constanse.dart';
import '../main.dart';
import '../test.dart';
import 'Container.dart';
import 'Show Location.dart';

class ShowImagePost extends StatelessWidget {
  ShowImagePost({super.key});

  TextEditingController mind = TextEditingController();
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  var imagepostname, image;

  @override
  Widget build(BuildContext context) {
    var imageurl;
    var userLocationl;
    File file;
    double h = Get.height;
    double w = Get.width;
    Object? username = name!.get('name');
    var url;
    return InkWell(
      onTap: () {
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$w');
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(top: 60),
                height: h,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage('${ProfileUrl!.get('url')}'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: w - 160,
                            child: Row(
                              children: [
                                Text(
                                  '${username == null ? '' : username} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                BlocConsumer<GetFireDataCubit,
                                        GetFireDataState>(
                                    builder: (context, state) {
                                  return Text(
                                      '${userLocationl == null ? '' : 'is at $userLocationl'}');
                                }, listener: (context, state) {
                                  if (state is Getlocation) {
                                    userLocationl = state.cuntry;
                                  }
                                })
                              ],
                            ),
                          ),
                          BlocBuilder<GetFireDataCubit, GetFireDataState>(
                              builder: (context, state) {
                            return ElevatedButton(
                                onPressed: () async {
                                  print('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$state');
                                  print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW$userId');
                                  BlocProvider.of<GetFireDataCubit>(context).emit(GetImageContainer(ContainerUrl: ''));

                                  Loading().loading();
                                  List<dynamic> myList = [];

                                  if (state is Getlocation) {
                                    userLocationl = state.cuntry;
                                    await userPostes.add({
                                      'color':0,
                                      'id': '',
                                      'imageurl': imageurl,
                                      'userid': userId,
                                      'postState': 'image',
                                      'email': email,
                                      'likes': 'Be the first to like',
                                      'time': '${DateTime.now()}',
                                      'name': username,
                                      'profileurl': userpic,
                                      'aboutimage': mind.text,
                                      'location': userLocationl,
                                      'likeslist': myList
                                    });
                                  }
                                else  if (state is getVideoState) {
                                    await userPostes.add({
                                      'color':0,
                                      'id': '',
                                      'userid': userId,
                                      'vedioUrl':'${state.videoUrl}',
                                      'postState': 'video',
                                      'email': email,
                                      'likes': 'Be the first to like',
                                      'time': '${DateTime.now()}',
                                      'name': username,
                                      'profileurl': userpic,
                                      'aboutimage': mind.text,
                                      'location': userLocationl,
                                      'likeslist': myList
                                    });
                                  } else {
                                    await userPostes.add({
                                      'color':0,
                                      'id': '',
                                      'imageurl': imageurl,
                                      'userid': userId,
                                      'postState': 'image',
                                      'email': email,
                                      'likes': 'Be the first to like',
                                      'time': '${DateTime.now()}',
                                      'name': username,
                                      'profileurl': userpic,
                                      'aboutimage': mind.text,
                                      'location': userLocationl,
                                      'likeslist': myList
                                    });
                                  }
BlocProvider.of<GetFireDataCubit>(context).emit(GetImageContainer(ContainerUrl: ''));
                                  mind.clear();
                                  Get.back();
                                  Get.back();
                                },
                                child: Text(
                                  'Post',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ));
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: w - 16,
                            child: TextFormField(
                              key: form,
                              decoration: InputDecoration(
                                labelText: 'say something about post !',
                              ),
                              controller: mind,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        vedioIconButton(),
                        IconButton(
                            onPressed: () async {
                              var imagename;
// ignore: deprecated_member_use
                              var picked = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (picked != null) {
                                file = File(picked.path);
                                var randome = Random().nextInt(1000000);
                                imagename = '$randome' + basename(picked.path);
                                Loading().loading();
                                Reference ref = FirebaseStorage.instance
                                    .ref('postesImages')
                                    .child('$imagename');
                                await ref.putFile(file);
                                imageurl = await ref.getDownloadURL();
                                BlocProvider.of<GetFireDataCubit>(context).emit(
                                    GetImageContainer(ContainerUrl: imageurl));
                                print(imageurl);

                                Get.back();
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.cameraRetro,
                              color: Colors.teal,
                            )),
                        IconButton(
                            onPressed: () async {
                              var picked = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (picked != null) {
                                file = File(picked.path);
                                var randome = Random().nextInt(1000000);
                                imagepostname =
                                    '$randome' + basename(picked.path);
                                Loading().loading();
                                Reference ref = FirebaseStorage.instance
                                    .ref('postesImages')
                                    .child('$imagepostname');
                                await ref.putFile(file);
                                imageurl = await ref.getDownloadURL();
                                Get.back();
                                BlocProvider.of<GetFireDataCubit>(context).emit(
                                    GetImageContainer(ContainerUrl: imageurl));
                              }
                            },
                            icon: Icon(
                              FontAwesomeIcons.image,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          width: w - 360,
                        ),
                        ShowLocation(),
                      ],
                    ),
                    BlocBuilder<GetFireDataCubit, GetFireDataState>(
                      builder: (context, state) {
                        return state is getVideoState
                            ? VideoPlayerScreen(videoUrl: '${state.videoUrl}',containerH: 250,containerW: w,loading: 'no',)
                            : ImageContainrt(
                                image: imageurl,
                              );
                      },
                    ),
                  ],
                ),
              );
            });
      },
      child: Icon(
        FontAwesomeIcons.image,
        color: Colors.blue[300],
      ),
    );
  }
}
