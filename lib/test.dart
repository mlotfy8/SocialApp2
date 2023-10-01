import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final double containerH,containerW;
final loading;
  VideoPlayerScreen({required this.videoUrl,required this.containerH,required this.containerW,required this.loading});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  Icon ico=Icon(Icons.play_circle_outline,size: 40,color: Colors.white,);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {

        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(width: widget.containerW,height: widget.containerH,
      child: _controller.value.isInitialized
          ? InkWell(
        onTap: () {
          setState(() {
            if (_controller.value.isPlaying) {

              ico=Icon(Icons.play_circle_outline,size: 40,color: Colors.white,);
              _controller.pause();
              @override
              void dispose() {
                super.dispose();
                _controller.dispose();
              }
            } else {
              ico=Icon(Icons.pause_circle_outline_sharp,color: Colors.transparent,);
              _controller.play();
            }
          });
        },
        child: Stack(children: [
          Container(padding: EdgeInsets.only(top: 5),
            width: widget.containerW,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
            height: widget.containerH,
            child: VideoPlayer(_controller),
          ),
          Center(child: ico)
        ],
        ),
      )
          :widget.loading=='ok'? Center(child: CircularProgressIndicator(),): null,
    );
  }


}
