// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videourl;
  final int index;
  const VideoPlayerItem({Key? key, required this.videourl, required this.index})
      : super(key: key);
  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoplayercontroller;

  @override
  void initState() {
    super.initState();
    videoplayercontroller = VideoPlayerController.network(widget.videourl)
      ..initialize().then((value) {
        // if (mounted) {
        // }
        videoplayercontroller.play();
        videoplayercontroller.setVolume(1);
        videoplayercontroller.setLooping(true);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoplayercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          Center(
            child: VisibilityDetector(
                key: Key('videoplayer${widget.index}'),
                onVisibilityChanged: (VisibilityInfo info) {
                  debugPrint("${info.visibleFraction} of my widget is visible");
                  if (info.visibleFraction == 0) {
                    videoplayercontroller.pause();
                  } else {
                    videoplayercontroller.play();
                  }
                },
                child: AspectRatio(
                  aspectRatio: videoplayercontroller.value.aspectRatio,
                  child: VideoPlayer(videoplayercontroller),
                )),
          ),
          // Center(
          //   child: GestureDetector(
          //     onTap: () {
          //       videoplayercontroller.pause();
          //     },
          //     child: Icon(
          //       Icons.pause,
          //       color: Colors.red,
          //       size: 40,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
