import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  final isuploading = false.obs;
  uploadVideo(
      {required String songname,
      required String caption,
      required String videoPath}) async {
    try {
      String uid = firebaseauth.currentUser!.uid;
      isuploading.value = true;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var alldocs = await firestore.collection('videos').get();
      int len = alldocs.docs.length;

      String videourl =
          await _uploadVideoToStorage("video${len + 1}", videoPath);
      String thumbnail =
          await _uploadImageToStorage("Video ${len + 1}", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video${len + 1}",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songname: songname,
        caption: caption,
        videoUrl: videourl,
        profilephoto: (userDoc.data()! as Map<String, dynamic>)['profilephoto'],
        thumbnail: thumbnail,
      );

      await firestore.collection('videos').doc('Video${len + 1}').set(
            video.tojson(),
          );
      isuploading.value = false;
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }

  Future<String> _uploadVideoToStorage(String id, String videopath) async {
    Reference ref = firebasestorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressvideo(videopath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressvideo(String videopath) async {
    final compressedvideo = await VideoCompress.compressVideo(videopath,
        quality: VideoQuality.MediumQuality);
    return compressedvideo!.file;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebasestorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
