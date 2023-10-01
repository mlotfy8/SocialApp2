import 'package:flutter/cupertino.dart';
import 'package:socialapp2/Widgets/react.dart';
import 'package:socialapp2/Widgets/vedioState.dart';


import 'customeCircleAvatar.dart';
import 'customeRow.dart';
import 'hasProfileTitle.dart';

class updateProfileState extends StatelessWidget {
  const updateProfileState(
      {super.key, required this.index, required this.snapshot});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return snapshot.data!.docs[index].get('postState')!='video'? Container(
      child: Column(
        children: [
          customeRow(
            index: index,
            snapshot: snapshot,
            text: 'update his profile picture',
          ),
          snapshot.data!.docs[index].get('aboutimage') != ''
              ? hasProfileTitle(snapshot: snapshot, index: index)
              : customeCircleAvatar(
            index: index,
            snapshot: snapshot,
          ),
          reactcomments(snapshot: snapshot, index: index)
        ],
      ),
    ):vedioState(index: index, snapshot: snapshot);
  }
}