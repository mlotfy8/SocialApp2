
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp2/Widgets/react.dart';

import 'customeRow.dart';



class PostState extends StatelessWidget {
  PostState({super.key, required this.snapshot, required this.index});

  var snapshot, index, selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              topLeft: Radius.circular(26),
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20)),
          color: Colors.black12,
        ),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            customeRow(
                index: index, snapshot: snapshot, text: 'set a new post'),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Text(
                      '${snapshot.data!.docs[index].get(
                        'post',
                      )}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: 'NotoSerif',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            reactcomments(snapshot: snapshot, index: index)
          ],
        ));
  }
}
