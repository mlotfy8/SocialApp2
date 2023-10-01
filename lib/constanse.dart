import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'main.dart';
double h = Get.height;
double w = Get.width;
Object? username = name!.get('name');
Object? userpic = ProfileUrl!.get('url');
Object? userBack = BackUrl!.get('back');

var email = FirebaseAuth.instance.currentUser!.email;
var userId = FirebaseAuth.instance.currentUser!.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference userPostes = FirebaseFirestore.instance.collection('userpostes');

CollectionReference viewContainerImage =
    FirebaseFirestore.instance.collection('ContainerImage');
CollectionReference backgroundimage =
    FirebaseFirestore.instance.collection('backgroundimage');
CollectionReference profile = FirebaseFirestore.instance.collection('profile');
CollectionReference birthday =
    FirebaseFirestore.instance.collection('usersbirthday');
CollectionReference savePostes =
FirebaseFirestore.instance.collection('savePostes');
CollectionReference usersReacts =
FirebaseFirestore.instance.collection('usersReacts');
CollectionReference usersCommentes =
FirebaseFirestore.instance.collection('usersCommentes');
