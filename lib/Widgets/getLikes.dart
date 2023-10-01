import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp2/constanse.dart';

class getLikes extends StatelessWidget {
  const getLikes({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(20),
      width: w,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
      height: 400,
      child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) => Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                '${snapshot.data!.docs[index].get('profileUrl')}'),
                          ),SizedBox(width: 20,),Text('${snapshot.data!.docs[index].get('name')}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),)
                        ],
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          stream: usersReacts.where('id',isEqualTo: id).snapshots()),
    );
  }
}
