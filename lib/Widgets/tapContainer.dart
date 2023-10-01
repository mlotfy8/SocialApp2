import 'package:flutter/cupertino.dart';

class tapContainer extends StatelessWidget {
  const tapContainer({super.key, required this.snapshot, required this.index});

  final snapshot, index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                  '${snapshot.data!.docs[index].get('imageurl')}'),fit: BoxFit.fill)),
    );
  }
}