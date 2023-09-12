import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String path;

  CustomVideoPlayer({required this.path});
  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController videoController;
  bool load = false;

  void initalizeVideoPlayer() async {
    setState(() {
      load = true;
    });
    videoController = await VideoPlayerController.networkUrl(
      Uri.parse(widget.path),
    )
      ..initialize().then((_) {
        setState(() {});
        videoController.play();
      });

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initalizeVideoPlayer();
  }

  Widget videoPreview() {
    return load
        ? Center(
            child: CircularProgressIndicator(),
          )
        : videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              )
            : Container(
                child: Text('not working'),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('sssssssss'),
          Center(
            child: videoPreview(),
          ),
        ],
      ),
    );
  }
}
