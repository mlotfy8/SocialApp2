import 'package:flutter/cupertino.dart';

class imageContainer extends StatelessWidget {
  const imageContainer(
      {super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      width: 320,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(snapshot.data!.docs[index].get(
                'imageurl',
              )))),
    );
  }
}