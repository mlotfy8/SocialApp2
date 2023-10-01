import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/Widgets/tapContainer.dart';

class customeCircleAvatar extends StatelessWidget {
  const customeCircleAvatar(
      {super.key, required this.index, required this.snapshot});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
              title: '',
              content: tapContainer(
                snapshot: snapshot,
                index: index,
              ));
        },
        child: CircleAvatar(
          radius: 100,
          backgroundImage:
              NetworkImage('${snapshot.data!.docs[index].get('imageurl')}'),
        ),
      ),
    );
  }
}
