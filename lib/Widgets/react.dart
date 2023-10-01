import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/Widgets/getLikes.dart';
import 'package:socialapp2/main.dart';

import '../Methodes/Loading.dart';
import '../constanse.dart';
import 'getCommentes.dart';

class reactcomments extends StatelessWidget {
  reactcomments({super.key, required this.snapshot, required this.index});

  TextEditingController mind = TextEditingController();

  final snapshot, index;
  Icon like = Icon(
    Icons.recommend,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        getLikes(id: snapshot.data!.docs[index].id),
                      );
                    },
                    child: Text(
                        '     ${snapshot.data!.docs[index].id == '0' ? 'Be the first to like' : '${snapshot.data!.docs[index].get('likes')}  like'}')),
              )
            ],
          ),
          Divider(),
          SizedBox(
            height: 35,
            child: Row(children: [
              SizedBox(
                width: w - 340,
              ),
              IconButton(
                  onPressed: () async {
                    var userid = FirebaseAuth.instance.currentUser!.uid;
                    List? likeslist = [];
                    String id = snapshot.data!.docs[index].id;
                    await userPostes.doc('$id').update({
                      'id': '$id',
                    });
                    await userPostes.doc('$id').get().then((value) async {
                      likeslist = value.get('likeslist');
                      if (likeslist!.contains('$email')) {
                        like = Icon(
                          Icons.recommend,
                        );
                        usersReacts.doc('${id + userid}').delete();
                        print('Contain$likeslist');
                        likeslist!.remove('$email');
                        var newlike = likeslist!.length;
                        print('11111111111111111111111111$newlike');

                        await userPostes.doc('$id').update({
                          'color': 0,
                          'likes':
                              '${newlike == 0 ? 'Be the first to like' : likeslist!.length}',
                          'likeslist': likeslist
                        });
                        print(likeslist!.length);
                      } else {
                        like = Icon(
                          Icons.recommend,
                          color: Colors.blue,
                        );
                        print('2222222222222222');
                        print('else${likeslist!.toString()}');
                        likeslist!.add('$email');
                        int newlike = likeslist!.length;

                        await userPostes.doc('$id').update({
                          'color': 1,
                          'likes': '$newlike',
                          'likeslist': likeslist
                        });
                        usersReacts.doc('${id + userid}').set({
                          'profileUrl': ProfileUrl!.get('url'),
                          'name': name!.get('name'),
                          'id': '$id'
                        });

                        print(likeslist!.length);
                      }
                    });

                    // List<String> myList = List<String>.from(snapshot.data()['likeslist']);

/*
                    List? a;

                    List likeslist;
                    await userPostes
                        .where('id', isEqualTo: id)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) async {
                        likeslist = element.get('likeslist');
                        print('QQQQQQQQQQQQQQQQQQQQ$likeslist');

                      });
                    });
 */
                  },
                  icon: Icon(
                    Icons.recommend,
                    color: snapshot.data!.docs[index].get('color') == 0
                        ? Colors.black
                        : Colors.blue,
                  )),
              Text(
                'likes',
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                  onPressed: () async {
                    String id=snapshot.data!.docs[index].id;
                    Get.bottomSheet(isScrollControlled:true,
                      Container(
                        decoration: BoxDecoration(color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        )),
                        height: 600,
                        child: Column(
                          children: [

                            getCommentes(id: id),
                            Padding(
                              padding:  EdgeInsets.only(top: 10,left: 5,right: 5),
                              child: TextFormField(onFieldSubmitted: (val) async {
                                await usersCommentes.add({
                                  'profileUrl': ProfileUrl!.get('url'),
                                  'name': name!.get('name'),
                                  'comment':'$val',
                                  'id':id,
                                  'userid':userId
                                });
                                Get.back();
                              },
                                decoration: InputDecoration(
                                  labelText: 'enter your comment ',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                ),


                                //   controller: mind,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.mode_comment_outlined)),
              Text(
                'comments',
                style: TextStyle(fontSize: 16),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.shortcut)),
              Text(
                'share',
                style: TextStyle(fontSize: 16),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
