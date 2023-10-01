import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../Cubit/get_fire_data_cubit.dart';
import '../Screenes/myprofile.dart';
import '../constanse.dart';
import '../main.dart';
import 'ShowImagePost.dart';
import 'ShowMind.dart';

class CustomeAppBar extends StatelessWidget {
  CustomeAppBar({
    super.key,
  });

  var currenuser = FirebaseAuth.instance.currentUser!.uid;

  Object? username = name!.get('name');
  var url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: w - 360, top: h - 795, right: w - 358),
      child: Container(
        width: w - 5,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black45,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 3,
            ),
            InkWell(onTap: () {
              Get.to(() => myprofile());
            }, child: BlocBuilder<GetFireDataCubit, GetFireDataState>(
              builder: (context, state) {
                return CircleAvatar(
                  backgroundImage: NetworkImage('${ProfileUrl!.get('url')}'),
                  radius: 30,
                );
              },
            )),
            Container(
              width: w - 280,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  '$username',
                  style: TextStyle(
                      fontFamily: 'NotoSerif',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
                width: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70),
                child: ShowMind(

                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ShowImagePost(),
            )
          ],
        ),
      ),
    );
  }
}
