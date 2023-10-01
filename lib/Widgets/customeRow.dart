import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';


import '../Cubit/get_fire_data_cubit.dart';
import '../constanse.dart';
import '../main.dart';
import 'ShowMind.dart';
import 'imagePicker.dart';

class customeRow extends StatelessWidget {
  customeRow(
      {super.key,
      required this.index,
      required this.snapshot,
      required this.text});

  final snapshot, index;
  final String text;
  TextEditingController mind = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profilePic =
        snapshot.data!.docs[index].get('postState') == 'updateProfile'
            ? ProfileUrl!.get('url')
            : BackUrl!.get('back');

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            '${snapshot.data!.docs[index].get('profileurl')}',
          ),
          radius: 28,
        ),
        SizedBox(
          height: 50,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Text(
                      ' ${snapshot.data!.docs[index].get('name')}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'NotoSerif',
                          color: Colors.black),
                    ),
                    Container(
                      width: 180,
                      child: Text(' $text',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          )),
                    ),
                    PopupMenuButton<String>(
                        icon: Icon(Icons.keyboard_control),
                        itemBuilder: (BuildContext context) {
                          return FirebaseAuth.instance.currentUser!.uid ==
                                  snapshot.data!.docs[index].get('userid')
                              ? <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'currentuseroption1',
                                    child: Text(' Edit Post'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'currentuseroption2',
                                    child: Text(' Save Post'),
                                  ),
                                ]
                              : <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'option2',
                                    child: Text(' Save Post'),
                                  ),
                                ];
                        },
                        onSelected: FirebaseAuth.instance.currentUser!.uid ==
                                userId
                            ? (String value) async {
                                String id = snapshot.data.docs[index].id;
                                await userPostes
                                    .doc('$id')
                                    .update({'id': '$id'});
                                userPostes
                                    .doc('$id')
                                    .snapshots()
                                    .forEach((element) {
                                  var s = element.get('postState');
                                  print('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ$s');
                                });
                                switch (value) {
                                  case 'currentuseroption1':
                                    {
                                      snapshot.data!.docs[index]
                                                  .get('postState') ==
                                              'post'
                                          ? await userPostes
                                              .where('id', isEqualTo: id)
                                              .get()
                                              .then((value) {
                                              String post;
                                              value.docs.forEach((element) {
                                                post = element.get('post');
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20))),
                                                  context: context,
                                                  builder: (context) {
                                                    return modelButtonSheetContent(
                                                      text: '$post',
                                                      lable: 'Edit Post',
                                                      id: id,
                                                    );
                                                  },
                                                );
                                              });
                                            })
                                          : showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20))),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: Get.height,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 50),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 30,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      '${ProfileUrl!.get('url')}'),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '$username',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0,
                                                                right: 10),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: BlocConsumer<
                                                                GetFireDataCubit,
                                                                GetFireDataState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                                if (state
                                                                    is GetbackImage) {
                                                                  profilePic = state
                                                                      .BackImage;
                                                                  print(
                                                                      'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP$profilePic');
                                                                } else if (state
                                                                    is GetprofileImage) {
                                                                  profilePic = state
                                                                      .profileImage;
                                                                  print(
                                                                      'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP2222222222PPP$profilePic');
                                                                }
                                                              },
                                                              builder: (context,
                                                                  state) {
                                                                return ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await userPostes
                                                                          .doc(
                                                                              '$id')
                                                                          .update({
                                                                        'aboutimage': mind.text ==
                                                                                ''
                                                                            ? snapshot.data!.docs[index].get('aboutimage')
                                                                            : mind.text,
                                                                        'profileurl':
                                                                            ProfileUrl!.get('url'),
                                                                        'imageurl':
                                                                            profilePic,
                                                                      });
                                                                      mind.clear();
                                                                      Get.back();

                                                                      BlocProvider.of<GetFireDataCubit>(
                                                                              context)
                                                                          .emit(
                                                                              getNewPic(newPic: ''));
                                                                      Get.snackbar(
                                                                          'Hi $username',
                                                                          'Your post has been updated',
                                                                          snackPosition: SnackPosition
                                                                              .BOTTOM,
                                                                          backgroundColor:
                                                                              Colors.black38);
                                                                    },
                                                                    child: Text(
                                                                      'Update',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ));
                                                              },
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          controller: mind,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  '  ${snapshot.data!.docs[index].get('aboutimage')}',
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 60,
                                                      ),
                                                      Text(
                                                        (' ${snapshot.data!.docs[index].get('postState') == 'updateProfile' ? 'Edit your profile picture' : 'Edit your background picture'}'),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'NotoSerif'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      imagePicker(
                                                        stat:
                                                            '${snapshot.data!.docs[index].get('postState')}',
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Divider(),
                                                      BlocConsumer<
                                                          GetFireDataCubit,
                                                          GetFireDataState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is GetbackImage) {
                                                            profilePic =
                                                                state.BackImage;
                                                            print(
                                                                'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE11111111111111$profilePic');
                                                          } else if (state
                                                              is GetprofileImage) {
                                                            profilePic = state
                                                                .profileImage;
                                                            print(
                                                                'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE222222222222222$profilePic');
                                                          } else if (state
                                                              is getNewPic) {
                                                            profilePic =
                                                                state.newPic;
                                                            print(
                                                                'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE3333333333$profilePic');
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            width: 300,
                                                            height: 300,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        20),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        '$profilePic'),
                                                                    fit: BoxFit
                                                                        .fill)),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                    }

                                    break;
                                  case 'currentuseroption2':
                                    {
                                      snapshot.data!.docs[index]
                                                  .get('postState') ==
                                              'post'
                                          ? await userPostes
                                              .doc('$id')
                                              .get()
                                              .then((value) async {
                                              String id = value.get('id');
                                              bool islike = value.get('islike');
                                              int likes = value.get('likes');
                                              String name = value.get('name');
                                              String postState =
                                                  value.get('postState');
                                              String profileurl =
                                                  value.get('profileurl');
                                              String time = value.get('time');
                                              String post = value.get('post');
                                              String userid =
                                                  value.get('userid');
                                              await savePostes.add({
                                                'id': '$id',
                                                'islike': '$islike',
                                                'userid': '$userid',
                                                'likes': '$likes',
                                                'name': '$name',
                                                'profileurl': '$profileurl',
                                                'time': '$time',
                                                'postState': '$postState',
                                                'saveId': '$userId',
                                                'post': '$post'
                                              });
                                            })
                                          : await userPostes
                                              .doc('$id')
                                              .get()
                                              .then((value) async {
                                              String aboutimage =
                                                  value.get('aboutimage');
                                              String email = value.get('email');
                                              String id = value.get('id');
                                              String imageurl =
                                                  value.get('imageurl');
                                              bool islike = value.get('islike');
                                              int likes = value.get('likes');
                                              String name = value.get('name');
                                              String postState =
                                                  value.get('postState');
                                              String profileurl =
                                                  value.get('profileurl');
                                              String time = value.get('time');
                                              String userid =
                                                  value.get('userid');
                                              await savePostes.add({
                                                'aboutimage': aboutimage,
                                                'email': email,
                                                'id': id,
                                                'imageurl': imageurl,
                                                'islike': islike,
                                                'likes': likes,
                                                'name': name,
                                                'profileurl': profileurl,
                                                'time': time,
                                                'userid': userid,
                                                'savedId': userId,
                                                'postState': postState,
                                              });
                                            });
                                      Get.snackbar('The post has been saved',
                                          'Check the saved to see it',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.black38);
                                    }
                                    break;
                                }
                              }
                            : (String value) {
                                switch (value) {}
                              })
                  ],
                ),
              ),
              SizedBox(
                width: w - 80,
                height: 13,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //
                        ' ${Jiffy.parse(snapshot.data!.docs[index].get('time')).fromNow()}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
