import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilephoto;

  Video({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.profilephoto,
    required this.shareCount,
    required this.songname,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videoUrl,
  });
  Map<String, dynamic> tojson() {
    return {
      "username": username,
      "uid": uid,
      "id": id,
      "likes": likes,
      "commentCount": commentCount,
      "shareCount": shareCount,
      "songname": songname,
      "caption": caption,
      "videoUrl": videoUrl,
      "thumbnail": thumbnail,
      "profilephoto": profilephoto,
    };
  }

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      songname: snapshot['songname'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      profilephoto: snapshot['profilephoto'],
      thumbnail: snapshot['thumbnail'],
    );
  }
}
