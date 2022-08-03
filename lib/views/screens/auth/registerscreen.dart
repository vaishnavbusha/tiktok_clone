// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/textinputfield.dart';

import '../../../constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TikTok Clone',
                    style: TextStyle(
                        fontFamily: 'gilroy_bold',
                        fontSize: 40,
                        color: buttonColor),
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'gilroy_bold',
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 64,
                          backgroundImage: (authcontroller
                                      .no_of_times_profilechanged.value !=
                                  0)
                              ? Image.file(authcontroller.pickedImage.value)
                                  .image
                              : NetworkImage(
                                  'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                          backgroundColor: Colors.black,
                        );
                      }),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () {
                            authcontroller.pickimage();

                            //authcontroller.isimagepicked.value = false;
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                        controller: _usernamecontroller,
                        labeltext: 'Username',
                        isObscure: false,
                        icon: Icons.person_outline_rounded),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      controller: _emailcontroller,
                      labeltext: 'Email',
                      isObscure: false,
                      icon: Icons.email_outlined,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                        controller: _passwordcontroller,
                        labeltext: 'Password',
                        isObscure: true,
                        icon: Icons.lock_outline_rounded),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () {
                      authcontroller.registerUser(
                          username: _usernamecontroller.text,
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text,
                          image: authcontroller.getprofilephoto);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontFamily: 'gilroy_bold', fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gilroy_regular',
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: buttonColor,
                            fontFamily: 'gilroy_regular',
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
