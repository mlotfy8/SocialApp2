part of 'get_fire_data_cubit.dart';

@immutable
abstract class GetFireDataState {}

class GetFireDataInitial extends GetFireDataState {}

class GetprofileImage extends GetFireDataState {
  final String profileImage;

  GetprofileImage({required this.profileImage});
}

class GetbackImage extends GetFireDataState {
  var BackImage;

  GetbackImage({required this.BackImage});
}

class Getmind extends GetFireDataState {
  final String text;

  Getmind({required this.text});
}

class GetImageContainer extends GetFireDataState {
  final String ContainerUrl;

  GetImageContainer({required this.ContainerUrl});
}

class Getusername extends GetFireDataState {
  final String username;

  Getusername({required this.username});
}

class Getlocation extends GetFireDataState {
  var cuntry;

  Getlocation({required this.cuntry});
}

class getNewPic extends GetFireDataState {
  final String newPic;

  getNewPic({required this.newPic});
}
class getPostState extends GetFireDataState {
  final String postState;

  getPostState({required this.postState});
}
class getVideoState extends GetFireDataState {
  final String videoUrl;

  getVideoState({required this.videoUrl});
}