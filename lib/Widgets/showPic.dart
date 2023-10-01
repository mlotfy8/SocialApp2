import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class customeDialog extends StatelessWidget {
   customeDialog({super.key, required this.buttonText, required this.url});

  final String buttonText;
   var url;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.defaultDialog(
              title: '',
              content: Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('$url'), fit: BoxFit.fill)),
              ));
        },
        child: Text(
          'Show Your $buttonText Picture',
          style: TextStyle(fontSize: 18),
        ));
  }
}
