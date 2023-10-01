import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/constanse.dart';

class getCommentes extends StatelessWidget {
  const getCommentes({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: w,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey,
      ),
      child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                        onLongPress: () {
                          if (snapshot.data!.docs[index].get('userid') ==
                              FirebaseAuth.instance.currentUser!.uid) {
                            Get.defaultDialog(
                                title: 'Do you want to delete this comment?',
                                content: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red),
                                      width: 80,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () async {
                                            String id2 =
                                                snapshot.data!.docs[index].id;
                                            await usersCommentes
                                                .doc('$id2')
                                                .delete();
                                            Get.back();
                                            Get.snackbar(' Hi $username',
                                                'Your comment has been deleted',
                                                snackPosition: SnackPosition.BOTTOM,
                                                backgroundColor: Colors.black38);
                                          },
                                          child: Text(
                                            'confirm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blue),
                                      width: 80,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          )),
                                    ),
                                  ],
                                ));
                          }
                        },
                        child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black38),
                            child: ListTile(
                              leading: SizedBox(
                                width: 108,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          '${snapshot.data!.docs[index].get('profileUrl')}'),
                                    ),
                                    Text(
                                      '  ${snapshot.data!.docs[index].get('name')}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title:
                                              '${snapshot.data!.docs[index].get('name')}',
                                          content: Text(
                                              '${snapshot.data!.docs[index].get('comment')}'));
                                    },
                                    child: Text(
                                      '${snapshot.data!.docs[index].get('comment')}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            )),
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          stream: usersCommentes.where('id', isEqualTo: id).snapshots()),
    );
  }
}
