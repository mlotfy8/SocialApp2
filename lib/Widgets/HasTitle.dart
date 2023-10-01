import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialapp2/Widgets/tapContainer.dart';

import 'imageCintainer.dart';



class hasTitle extends StatelessWidget {
  hasTitle({super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0,bottom: 5),
              child: Text(
                '${snapshot.data!.docs[index].get(
                  'aboutimage',
                )}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        InkWell(
            onTap: () {
              Get.defaultDialog(
                  radius: 10,
                  title: '',
                  content: tapContainer(
                    snapshot: snapshot,
                    index: index,
                  ));
            },
            child: imageContainer(
              snapshot: snapshot,
              index: index,
            )),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
/*
    onlike(String id) async {
    bool? updateislike;
    await getuserslikes.add({
      'id': '$id',
      'likes': likes,
      'name': '$postname',
      'imageurl': url,
    });
    await getuserslikes.doc(id).set({
      'id': '$id',
      'likes': likes,
      'name': '$postname',
      'imageurl': url,
    });
    await curentuserpostes.doc(id).update({'id': id});
    await curentuserpostes
        .where('id', isEqualTo: id)
        .get()
        .then((value) => value.docs.forEach((element) {
      setState(() {
        updateislike = element.get('islike');
      });
    }));
    print('=====================================================$updateislike');
    if (updateislike == false) {
      setState(() {
        islike = true;
        likes++;
      });
      print('+++++++++++++++++++++++');
      await curentuserpostes.doc(id).update({'likes': likes, 'islike': islike});
      await getuserslikes.doc('$id').update({
        'likes': likes,
      });
    } else if (updateislike == true) {
      print('-----------------------');
      setState(() {
        islike = false;
        likes--;
      });
      await curentuserpostes.doc(id).update({'likes': likes, 'islike': islike});
      await getuserslikes.doc('$id').update({
        'likes': likes,
      });
    } else {
      return;
    }
    return likes;
  }
   */
}
