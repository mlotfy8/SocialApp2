import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Loading {
  loading() {
    Get.defaultDialog(barrierDismissible:false,
        title: 'Please wait',
        titleStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 20, fontFamily: 'NotoSerif'),
        content: Center(
          child: CircularProgressIndicator(),
        ));
  }
}