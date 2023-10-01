
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constanse.dart';
import '../main.dart';

class Birthday extends StatelessWidget {
  Birthday({super.key});

  String bornat = '';
  GlobalKey<FormState> form = new GlobalKey<FormState>();
  TextEditingController mind = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.black45,
                  height: 600,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              '$userpic',
                            ),
                            radius: 30,
                          ),
                          Text(
                            '  $username',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          ElevatedButton(
                              onPressed: () async {
                                var formstate = form.currentState;
                                if (formstate!.validate()) {
                                  await birthday.add({
                                    'userid': userId,
                                    'name': username,
                                    'birtday': 'Born in  ${mind.text}'
                                  });

                                  Get.back();
                                }
                              },
                              child: Text(
                                'Post',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'NotoSerif'),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: form,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter your birthday',
                            ),
                            controller: mind,
                            validator: (txt) {
                              if (txt == '') return 'Required field';
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        icon: Icon(Icons.edit));
  }

/*
   methodbirth() async {
     await birthday.where('userid', isEqualTo: userId).get().then((value) {
       value.docs.forEach((element) {
         setState(() {
           birth = element.get('birtday');
         });
       });
     });
  }
   */
}
