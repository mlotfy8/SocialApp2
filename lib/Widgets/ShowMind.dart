import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Methodes/Loading.dart';
import '../constanse.dart';
import '../main.dart';

class ShowMind extends StatelessWidget {
  ShowMind({super.key});

  @override
  Widget build(BuildContext context) {
    Object? username = name!.get('name');
    var url;
    return TextButton(
      child: Text(
        'what`s in your mind',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
      ),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            context: context,
            builder: (context) {
              return modelButtonSheetContent(
                lable: '',
                text: 'what`s in your mind',
                id: '',
              );
            });
      },
    );
  }
}

class modelButtonSheetContent extends StatelessWidget {
  modelButtonSheetContent(
      {super.key, required this.text, required this.lable, required this.id});

  GlobalKey<FormState> form = new GlobalKey<FormState>();
  TextEditingController mind = TextEditingController();
  final String text, lable, id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        )),
        height: 400,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('$lable',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'NotoSerif')),
            SizedBox(
              height: h - 790,
            ),
            Row(
              children: [
                SizedBox(
                  width: w - 350,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('${ProfileUrl!.get('url')}'),
                  radius: 30,
                ),
                SizedBox(
                  width: w - 350,
                ),
                Text('$username',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'NotoSerif')),
                SizedBox(
                  width: w - 260,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Loading().loading();
                      if (lable == '') {
                        List<dynamic> myList = [];
                        await userPostes.add({
                          'color':0,
                          'likeslist': myList,
                          'postState': 'post',
                          'post': mind.text,
                          'userid': userId,
                          'profileurl': userpic,
                          'likes': 'Be the first to like',
                          'id': '',
                          'name': username,
                          'time': '${DateTime.now()}',
                        });
                      } else {
                        print('WWWWWWWWWWWWWWWWWWWWWWWW$lable');
                        await userPostes
                            .doc('$id')
                            .update({'post': '${mind.text}'});
                      }
                      mind.clear();
/*
                                Get.snackbar('', '',
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 5, right: 5),
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: Text(
                                      'Hi $username',
                                      style: TextStyle(
                                          fontFamily: 'NotoSerif',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    messageText: Text(
                                      'Your post has been published successfully',
                                      style: TextStyle(
                                          fontFamily: 'NotoSerif',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ));
 */
                      Get.back();
                      Get.back();
                      lable == ''
                          ? null
                          : Get.snackbar(
                              'Hi $username', 'Your post has been updated',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black38);
                    },
                    child: Text(
                      '${lable == '' ? 'Post' : 'Update'}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'NotoSerif'),
                    )),
                SizedBox(
                  width: h - 780,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '$text',
                ),

                /*
                validator: (val){
                if (val!.isEmpty==true) {
                  return 'Required field';
                }
              },
           */

                controller: mind,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
