import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/get_fire_data_cubit.dart';
import '../Widgets/ImageState.dart';
import '../Widgets/BirthDay.dart';
import '../Widgets/Set Background Pic.dart';
import '../Widgets/postState.dart';
import '../Widgets/updateProfile.dart';
import '../constanse.dart';
import '../main.dart';

class myprofile extends StatefulWidget {
  const myprofile({super.key});

  @override
  State<myprofile> createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  var profileurl;
  String bornat = '';
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  TextEditingController mind = new TextEditingController();
  var rand;
  var file;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFireDataCubit, GetFireDataState>(
      listener: (context, state) {
        if (state is GetprofileImage) {}
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SetBackgroundPic(),
                      Padding(
                        padding: const EdgeInsets.only(top: 120, left: 10),

                        child: BlocConsumer<GetFireDataCubit, GetFireDataState>(
                          listener: (context, state) {
if(state is GetprofileImage)
  {
    print('QQQQQQQQQQQQQQQQQQQQQQQQQQQ${ProfileUrl!.get('url')}');

  }
  },
                          builder: (context, state) {
                            return CircleAvatar(
                              radius: 93,
                              backgroundColor: Colors.white70,
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage: NetworkImage('${ProfileUrl!.get('url')}'),
                                foregroundColor: Colors.black,
                                child: updateProfile(),),);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'NotoSerif'),
                        ),
                        Birthday(),
                      ],
                    ),
                  ),
/*
                  Row(
                    children: [
                      Text(
                        '  ', //${birth == null ? '' : birth}
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'NotoSerif'),
                      )
                    ],
                  ),
 */
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Container(
                      child: StreamBuilder(
                          stream: userPostes
                              .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                  snapshot
                                      .data!.docs[index]
                                      .get('postState') ==
                                      'post'
                                      ? PostState(
                                    index: index,
                                    snapshot: snapshot,
                                  )
                                      : ImageState(
                                      snapshot: snapshot, index: index),
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: snapshot.data!.docs.length);
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
