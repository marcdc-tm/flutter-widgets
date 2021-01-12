import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  Widget build(BuildContext buildContext) => MaterialApp(
    home: Scaffold(
      body: AppTree(),
      appBar: AppBar(title: Text("Video afspelen"),),
    ),
  );
}

class AppTree extends StatefulWidget{
  _AppTreeState createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {
  VideoPlayerController videoController = VideoPlayerController.asset("assets/video/bees.mp4");

  void initState() {
    videoController.setLooping(true);
    videoController.initialize();
    super.initState();
  }

  Widget build(BuildContext context) {
    bool isVisible = true;

    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 640 / 360,  // breedte gedeeld door hoogte
          child: VideoPlayer(videoController)
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              videoController.value.isPlaying ? videoController.pause() : videoController.play();
            });
          },
          child: videoController.value.isPlaying ? Icon(Icons.pause, size: 60) : Icon(Icons.play_arrow, size: 60),
        ),
      ]
    );
  }
}