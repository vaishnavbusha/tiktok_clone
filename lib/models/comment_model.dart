// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String comment;
  final datepublished;
  List likes;
  String profilephoto;
  String uid;
  String id;

  CommentModel({
    required this.comment,
    required this.datepublished,
    required this.id,
    required this.likes,
    required this.profilephoto,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> tojson() {
    return {
      "comment": comment,
      "datepublished": datepublished,
      "id": id,
      "likes": likes,
      "profilephoto": profilephoto,
      "uid": uid,
      "username": username,
    };
  }

  static CommentModel fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datepublished: snapshot['datepublished'],
      likes: snapshot['likes'],
      profilephoto: snapshot['profilephoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
