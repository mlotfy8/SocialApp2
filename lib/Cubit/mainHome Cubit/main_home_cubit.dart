import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

part 'main_home_state.dart';

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit() : super(MainHomeInitial());

  @override
  void onClose(BlocBase bloc) {
    print('close   $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    print('create   $bloc');
  }
}
