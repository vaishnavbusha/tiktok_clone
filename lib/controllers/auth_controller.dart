// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_cast, non_constant_identifier_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File> pickedImage = (null as File).obs;

  RxInt no_of_times_profilechanged = 0.obs;

  File? get getprofilephoto => pickedImage.value;

  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseauth.currentUser);
    _user.bindStream(firebaseauth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void registerUser(
      {required String username,
      required String email,
      required String password,
      required File? image}) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseauth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadurl = await _uploadtoStorage(image);

        UserModel user = UserModel(
            name: username,
            email: email,
            profilephoto: downloadurl,
            uid: cred.user!.uid);
        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.tojson());
      } else {
        //Get.rawSnackbar();
        Get.snackbar(
          'Error creating your account',
          "Fill-up all the fields for successful registration",
        );
      }
    } catch (e) {
      Get.snackbar('Error creating your account', e.toString());
    }
  }

  void loginuser({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseauth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar('Error signing-in', "Enter all the fields",
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING);
      }
    } catch (e) {
      Get.snackbar('Error Signing-in your account', e.toString());
    }
  }

////upload user selected image to firebase storage
  Future<String> _uploadtoStorage(File image) async {
    Reference ref = firebasestorage
        .ref()
        .child('profilepics')
        .child(firebaseauth.currentUser!.uid);
    UploadTask uploadtask = ref.putFile(image);
    TaskSnapshot snap = await uploadtask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  void pickimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedimage != null) {
      no_of_times_profilechanged++;
      Get.snackbar('Profile Picture',
          'You have successfuly selected your profile picture!');
      pickedImage = Rx<File>(File(pickedimage.path));
    }
  }

  void signOut() async {
    await firebaseauth.signOut();
  }
}
