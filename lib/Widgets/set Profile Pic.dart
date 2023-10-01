import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';



import '../Methodes/Loading.dart';
import '../Screenes/main Home.dart';
import '../constanse.dart';
import '../main.dart';

class SetProfilePicture extends StatefulWidget {
  const SetProfilePicture({super.key});

  @override
  State<SetProfilePicture> createState() => _SetProfilePictureState();
}

class _SetProfilePictureState extends State<SetProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  TextEditingController mind = new TextEditingController();

  var birth, rand, url, url2, file, imageurl, currentlist;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedBuilder(
                  builder: (context, _) => SlideTransition(
                    position: slidingAnimation,
                    child: Text(
                      'Welcome $username',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  animation: slidingAnimation,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Choose Your Profile Picture',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                      color: Colors.blueGrey)),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        var imagename;
                        // ignore: deprecated_member_use
                        var picked = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (picked != null) {
                          file = File(picked.path);
                          var randome = Random().nextInt(1000000);
                          imagename = '$randome' + basename(picked.path);
                          Loading().loading();
                          Reference ref = FirebaseStorage.instance
                              .ref('images')
                              .child('$imagename');
                          await ref.putFile(file);
                          imageurl = await ref.getDownloadURL();
                          imageurl = imageurl;
                          await profile.add({
                            'imageurl': imageurl,
                            'userid': userId,
                            'time': DateTime.now()
                          });
                          ProfileUrl!.setString('url', '$imageurl');

                          Get.back();
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
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
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'NotoSerif'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        var imagename;
                        // ignore: deprecated_member_use
                        var picked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          file = File(picked.path);
                          var randome = Random().nextInt(1000000);
                          imagename = '$randome' + basename(picked.path);
                          Loading().loading();
                          Reference ref = FirebaseStorage.instance
                              .ref('images')
                              .child('$imagename');
                          await ref.putFile(file);
                          imageurl = await ref.getDownloadURL();
                          imageurl = imageurl;
                          await profile.add({
                            'imageurl': imageurl,
                            'userid': userId,
                            'time': DateTime.now()
                          });
                          ProfileUrl!.setString('url', '$imageurl');

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
                            ('Gallery'),
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'NotoSerif'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomeButton(
                text: 'Next',
              )
            ],
          ),
        ));
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  @override
  void initState() {
    initSlidingAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

class CustomeButton extends StatelessWidget {
  const CustomeButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Get.to(() => MainHome());
              },
              child: Text(
                '$text',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
            )
          ],
        ),
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.teal));
  }
}
