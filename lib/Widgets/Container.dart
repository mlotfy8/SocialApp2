import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/get_fire_data_cubit.dart';


class ImageContainrt extends StatelessWidget {
  ImageContainrt({super.key, required this.image});


  var image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFireDataCubit, GetFireDataState>(
      listener: (context, state) {
if(state is GetImageContainer)
  {
    print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC$image');

    image=state.ContainerUrl;
    print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC$image');
  }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(20),
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage('${image == null ? '' : image}'),
                  fit: BoxFit.fill)),
        );
      },
    );
  }
}
