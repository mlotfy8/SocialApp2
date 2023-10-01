import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp2/Widgets/react.dart';



import '../test.dart';
import 'customeRow.dart';


class vedioState extends StatelessWidget {
  const vedioState({super.key, required this.index, required this.snapshot});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customeRow(index: index, snapshot: snapshot, text: 'set a new video'),
          VideoPlayerScreen(
              videoUrl: '${snapshot.data!.docs[index].get('vedioUrl')}',containerH: 300,containerW: 300,loading: 'ok'),
          reactcomments(snapshot: snapshot, index: index)
        ],
      ),
    );
  }
}
