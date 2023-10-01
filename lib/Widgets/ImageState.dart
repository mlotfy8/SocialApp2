import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socialapp2/Widgets/customeRow.dart';
import 'package:socialapp2/Widgets/react.dart';
import 'package:socialapp2/Widgets/tapContainer.dart';

import '../constanse.dart';
import '../main.dart';
import 'HasTitle.dart';
import 'UpdateBackState.dart';
import 'imageCintainer.dart';

class ImageState extends StatelessWidget {
  final snapshot, index;

  ImageState({super.key, required this.snapshot, required this.index});

  bool islike = false;
  int likes = 0;
  double h = Get.height;
  double w = Get.width;
  var postname;

  @override
  Widget build(BuildContext context) {
    var url;
    Object? postname = name!.get('name');

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              topLeft: Radius.circular(26),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20)),
          color: Colors.black12,
        ),
        margin: EdgeInsets.all(5),
        child: snapshot.data!.docs[index].get('postState') == 'image'
            ? Column(
                children: [
                  SizedBox(
                    height: 60,
                    child:customeRow(index: index,snapshot: snapshot, text: 'set a new image',)
                  ),
                  snapshot.data!.docs[index].get('aboutimage') != ''
                      ? hasTitle(snapshot: snapshot, index: index)
                      : InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                radius: 10,
                                title: '',
                                content: tapContainer(
                                    snapshot: snapshot, index: index));
                          },
                          child:
                              imageContainer(snapshot: snapshot, index: index)),
                  reactcomments(snapshot: snapshot, index: index)
                ],
              )
            : UpgateBackState(
                snapshot: snapshot,
                index: index,
              ));
  }
}
