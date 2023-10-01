import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/Widgets/react.dart';
import 'package:socialapp2/Widgets/tapContainer.dart';


import 'imageCintainer.dart';

class hasBackTitle extends StatelessWidget {
  const hasBackTitle({super.key, required this.index, required this.snapshot});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Center(
            child: InkWell(
          onTap: () {
            Get.defaultDialog(
                radius: 10,
                title: '',
                content: tapContainer(
                  snapshot: snapshot,
                  index: index,
                ));
          },
          child: snapshot.data!.docs[index].get(
                    'aboutimage',
                  ) ==
                  ''
              ? imageContainer(
                  snapshot: snapshot,
                  index: index,
                )
              : hasbackTitle(
                  index: index,
                  snapshot: snapshot,
                ),
        )),
        SizedBox(
          height: 5,
        ),
        reactcomments(
          snapshot: snapshot,
          index: index,
        )
      ],
    );
  }
}

class hasbackTitle extends StatelessWidget {
  const hasbackTitle({super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '   ${snapshot.data!.docs[index].get('aboutimage')}',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          imageContainer(snapshot: snapshot, index: index),
        ],
      ),
    );
  }
}
