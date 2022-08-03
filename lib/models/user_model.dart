import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String profilephoto;
  String email;
  String uid;
  UserModel(
      {required this.email,
      required this.name,
      required this.profilephoto,
      required this.uid});

  // Map<String, dynamic> tojson()=>{
  //       "name": name,
  //       "profilephoto": profilephoto,
  //       "email": email,
  //       "uid": uid,
  //     };
  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "profilephoto": profilephoto,
      "email": email,
      "uid": uid,
    };
  }

  static UserModel fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      profilephoto: snapshot['profilephoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}
