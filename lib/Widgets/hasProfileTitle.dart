import 'package:flutter/cupertino.dart';

import 'customeCircleAvatar.dart';

class hasProfileTitle extends StatelessWidget {
  const hasProfileTitle(
      {super.key, required this.index, required this.snapshot});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${snapshot.data!.docs[index].get('aboutimage')}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        customeCircleAvatar(index: index, snapshot: snapshot),
      ],
    );
  }
}
