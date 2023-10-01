import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../Cubit/get_fire_data_cubit.dart';
import '../Methodes/Loading.dart';
import '../constanse.dart';
import '../test.dart';

class vedioIconButton extends StatelessWidget {
  vedioIconButton({super.key});

  var vedioname, vedioUrl, file;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {

          Get.bottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black38),
                height: 200,
                width: w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        // var imagename, imageurl, file;
// ignore: deprecated_member_use
                        final picked = await ImagePicker()
                            .pickVideo(source: ImageSource.camera);
                        file = File(picked!.path);

                        if (picked != null) {
                          if (picked != null) {
                            file = File(picked.path);
                            var randome = Random().nextInt(1000000);
                            vedioname = '$randome' + basename(picked.path);
                            Reference ref = FirebaseStorage.instance
                                .ref('vedioes')
                                .child('$vedioname');
                            Loading().loading();
                            await ref.putFile(file);
                            vedioUrl = await ref.getDownloadURL();
                            print('$vedioUrl');
                            BlocProvider.of<GetFireDataCubit>(context)
                                .emit(getVideoState(videoUrl: '$vedioUrl'));
                            Get.back();

                            Get.back();
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.teal,
                            size: 27,
                          ),
                          Text(
                            '   from camera',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        // var imagename, imageurl, file;
// ignore: deprecated_member_use
                        final picked = await ImagePicker()
                            .pickVideo(source: ImageSource.gallery);
                        file = File(picked!.path);

                        if (picked != null) {
                          if (picked != null) {
                            file = File(picked.path);
                            var randome = Random().nextInt(1000000);
                            vedioname = '$randome' + basename(picked.path);
                            Reference ref = FirebaseStorage.instance
                                .ref('vedioes')
                                .child('$vedioname');
                            Loading().loading();
                            await ref.putFile(file);
                            vedioUrl = await ref.getDownloadURL();
                            print('$vedioUrl');
                            BlocProvider.of<GetFireDataCubit>(context)
                                .emit(getVideoState(videoUrl: '$vedioUrl'));
                            Get.back();
                            Get.back();
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 27,
                          ),
                          Text(
                            '   from gallery',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));

      },
      icon: Icon(Icons.video_camera_back_outlined),
      iconSize: 28,
      color: Colors.blue,
    );
  }
}
