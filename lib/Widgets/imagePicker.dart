import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import '../Cubit/get_fire_data_cubit.dart';
import '../Methodes/Loading.dart';
import '../Screenes/main Home.dart';
import '../main.dart';


var birth, rand, file, imageurl;

class imagePicker extends StatelessWidget {
  const imagePicker({super.key, required this.stat});

  final String stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            var imagename;
// ignore: deprecated_member_use
            var picked =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (picked != null) {
              file = File(picked.path);
              var randome = Random().nextInt(1000000);
              imagename = '$randome' + basename(picked.path);
              Loading().loading();
              Reference ref =
                  FirebaseStorage.instance.ref('images').child('$imagename');
              await ref.putFile(file);
              imageurl = await ref.getDownloadURL();
              if (stat == 'updateProfile') {
                print('setprofile=====================$imageurl');
                ProfileUrl!.remove('url');
                ProfileUrl!.setString('url', '$imageurl');
              } else {

                BackUrl!.remove('back');
                BackUrl!.setString('back', '$imageurl');
              }
              Get.back();
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
              ),
              Icon(
                Icons.camera_alt_outlined,
                color: Colors.teal,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                ('Camera'),
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSerif'),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            var imagename;
// ignore: deprecated_member_use
            var picked =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (picked != null) {
              file = File(picked.path);
              var randome = Random().nextInt(1000000);
              imagename = '$randome' + basename(picked.path);
              Loading();
              Reference ref =
                  FirebaseStorage.instance.ref('images').child('$imagename');
              Loading().loading();

              await ref.putFile(file);
              imageurl = await ref.getDownloadURL();
              print(imageurl);

              if (stat == 'updateProfile') {
                print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS$stat');
                
                print('setprofile=====================$imageurl');
                ProfileUrl!.remove('url');
                ProfileUrl!.setString('url', '$imageurl');
                BlocProvider.of<GetFireDataCubit>(context)
                    .emit(GetprofileImage(profileImage: imageurl));
              } else {
                print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS$stat');

                BackUrl!.remove('back');
                BackUrl!.setString('back', '$imageurl');
                BlocProvider.of<GetFireDataCubit>(context)
                    .emit(GetbackImage(BackImage: imageurl));
                print('NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN${BackUrl!.get('back')}');
                
              }

              Get.back();
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.style_rounded,
                size: 30,
                color: Colors.teal,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                ('Gllary'),
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSerif'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
