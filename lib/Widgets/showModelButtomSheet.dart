import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/Widgets/showPic.dart';

import '../Cubit/get_fire_data_cubit.dart';
import '../constanse.dart';
import '../main.dart';
import 'imagePicker.dart';

class showModelButtomSheet extends StatelessWidget {
  showModelButtomSheet(
      {super.key,
      required this.text,
      required this.url,
      required this.stat,
      required this.buttonText,required this.hint});

  final String text, buttonText,hint;
  var url, profilePic;
  TextEditingController mind = TextEditingController();
  final String stat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU$url');
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            context: context,
            builder: (context) {
              return Container(
                height: Get.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 50),
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
                          Text(
                            '$username',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10),
                      child: Align(
                          alignment: Alignment.topRight,
                          child:
                              BlocConsumer<GetFireDataCubit, GetFireDataState>(
                            listener: (context, state) {
                              if (state is GetbackImage) {
                                profilePic = state.BackImage;
                                print(
                                    'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP$profilePic');
                              } else if (state is GetprofileImage) {
                                profilePic = state.profileImage;
                                print(
                                    'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP2222222222PPP$profilePic');
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                  onPressed: () async {
/*
                                    var newbackGround = BackUrl!.get('back');
                                    BlocProvider.of<GetFireDataCubit>(context)
                                        .emit(GetbackImage(
                                            BackImage: newbackGround));
 */
                                    List<dynamic> myList = [];
                                    await userPostes.add({
                                      'color':0,
                                      'id' : '',
                                      'color':0,
                                      'imageurl': profilePic,
                                      'userid': userId,
                                      'postState': '$stat',
                                      'email': email,
                                      'likes': 0,
                                      'islike': false,
                                      'time': '${DateTime.now()}',
                                      'name': username,
                                      'profileurl': userpic,
                                      'aboutimage': mind.text,
                                      'likeslist': myList
                                    });
                                    mind.clear();
                                    Get.back();

                                    BlocProvider.of<GetFireDataCubit>(context)
                                        .emit(getNewPic(newPic: ''));
                                  },
                                  child: Text(
                                    'Post',
                                    style: TextStyle(fontSize: 18),
                                  ));
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: mind,
                        decoration: InputDecoration(
                            hintText: '  say something about picture !',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      (' $text'),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSerif'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    imagePicker(
                      stat: '$stat',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    customeDialog(buttonText: buttonText, url: url),
                    BlocConsumer<GetFireDataCubit, GetFireDataState>(
                      listener: (context, state) {
                        if (state is GetbackImage) {
                          profilePic = state.BackImage;
                          print(
                              'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE11111111111111$profilePic');
                        } else if (state is GetprofileImage) {
                          profilePic = state.profileImage;
                          print(
                              'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE222222222222222$profilePic');
                        } else if (state is getNewPic) {
                          profilePic = state.newPic;
                          print(
                              'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE3333333333$profilePic');
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 300,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage('$profilePic'),
                                  fit: BoxFit.fill)),
                        );
                      },
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
