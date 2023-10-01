import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socialapp2/Widgets/react.dart';
import 'package:socialapp2/Widgets/tapContainer.dart';

import '../constanse.dart';
import 'HasBackTitle.dart';
import 'hasProfileTitle.dart';

class saveImageState extends StatelessWidget {
  const saveImageState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black38,
          centerTitle: true,
          title: Text(
            'Saved',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
          ),
        ),
        body: StreamBuilder(
          stream: savePostes.where('savedId',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    //
                    return snapshot.data!.docs[index].get('postState') != 'post'
                        ? saveImageContent(
                            snapshot: snapshot,
                            index: index,
                          )
                        : savePostContent(snapshot: snapshot, index: index);
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class getSavedPostes extends StatelessWidget {
  const getSavedPostes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black38,
          centerTitle: true,
          title: Text(
            'Saved',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
          ),
        ),
        body: StreamBuilder(
          stream: savePostes.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    //
                    return snapshot.data!.docs[index].get('postState') != 'post'
                        ? saveImageContent(
                            snapshot: snapshot,
                            index: index,
                          )
                        : savePostContent(snapshot: snapshot, index: index);
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class saveImageContent extends StatelessWidget {
  const saveImageContent(
      {super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return snapshot.data!.docs[index].get('postState') != 'updateProfile'
        ? Container(
            width: w,
            height: 365,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black12),
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
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
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontFamily: 'NotoSerif',
                                      color: Colors.black),
                                ),
                                Container(
                                  width: 169,
                                  child: Text(
                                      '   ${snapshot.data!.docs[index].get('postState') == 'updateProfile' ? 'update his profile picture' : 'update his background picture'}',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      )),
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.keyboard_control),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'option1',
                                        child: Text('unsave'),
                                      ),
                                    ];
                                  },
                                  onSelected: (String value) async {
                                    switch (value) {
                                      case 'option1':
                                        {
                                          String id =
                                              snapshot.data.docs[index].id;
                                          await FirebaseFirestore.instance
                                              .collection('savePostes')
                                              .doc('$id')
                                              .delete();
                                        }
                                        break;
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: w - 90,
                            height: 20,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //
                                    ' ${Jiffy.parse(snapshot.data!.docs[index].get('time')).fromNow()}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                snapshot.data!.docs[index].get('aboutimage') != ''
                    ? hasBackTitle(index: index, snapshot: snapshot)
                    : tapContainer(snapshot: snapshot, index: index),
              ],
            ),
          )
        : Container(
            width: w,
            height: 365,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black12),
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
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
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontFamily: 'NotoSerif',
                                      color: Colors.black),
                                ),
                                Container(
                                  width: 169,
                                  child: Text(
                                      '   ${snapshot.data!.docs[index].get('postState') == 'updateProfile' ? 'update his profile picture' : 'update his background picture'}',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      )),
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.keyboard_control),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'option1',
                                        child: Text('unsave'),
                                      ),
                                    ];
                                  },
                                  onSelected: (String value) async {
                                    switch (value) {
                                      case 'option1':
                                        {
                                          String id =
                                              snapshot.data.docs[index].id;
                                          await FirebaseFirestore.instance
                                              .collection('savePostes')
                                              .doc('$id')
                                              .delete();
                                        }
                                        break;
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: w - 90,
                            height: 20,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //
                                    ' ${Jiffy.parse(snapshot.data!.docs[index].get('time')).fromNow()}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hasProfileTitle(index: index, snapshot: snapshot),
                reactcomments(snapshot: snapshot, index: index)
              ],
            ),
          );
  }
}

class savePostContent extends StatelessWidget {
  const savePostContent(
      {super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
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
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontFamily: 'NotoSerif',
                                color: Colors.black),
                          ),
                          Container(
                            width: 169,
                            child: Text('   set a new post',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                )),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.keyboard_control),
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'option1',
                                  child: Text('unsave'),
                                ),
                              ];
                            },
                            onSelected: (String value) async {
                              switch (value) {
                                case 'option1':
                                  {
                                    String id = snapshot.data.docs[index].id;
                                    await FirebaseFirestore.instance
                                        .collection('savePostes')
                                        .doc('$id')
                                        .delete();
                                  }
                                  break;
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w - 90,
                      height: 20,
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
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Text(
                    '${snapshot.data!.docs[index].get(
                      'post',
                    )}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'NotoSerif',
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          reactcomments(snapshot: snapshot, index: index)
        ],
      ),
    );
  }
}
