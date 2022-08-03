// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/uploadvideo_controller.dart';
import 'package:tiktok_clone/views/widgets/textinputfield.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';

class ConfirmScreen extends StatefulWidget {
  final File videofile;

  final String videopath;
  const ConfirmScreen(
      {Key? key, required this.videofile, required this.videopath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songcontroller = TextEditingController();
  TextEditingController captioncontroller = TextEditingController();

  UploadVideoController uploadvideocontroller =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videofile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    songcontroller.dispose();
    captioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: songcontroller,
                      labeltext: 'Song Name',
                      icon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: captioncontroller,
                      labeltext: 'Caption',
                      icon: Icons.closed_caption_off_rounded,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return (uploadvideocontroller.isuploading.value == false)
                        ? ElevatedButton(
                            onPressed: () {
                              uploadvideocontroller.uploadVideo(
                                caption: captioncontroller.text,
                                songname: songcontroller.text,
                                videoPath: widget.videopath,
                              );
                            },
                            child: Text(
                              "Share",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        : CircularProgressIndicator();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
