// ignore_for_file: prefer_const_constructors,  prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;
  const CommentScreen({required this.id});
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController commentcontroller;
  CommentController commentController = Get.put(CommentController());
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    commentcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(widget.id);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                BackButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(comment.profilephoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.username,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: 'gilroy_bold'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(comment.datepublished.toDate()),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length} likes',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authcontroller.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Divider(),
                ListTile(
                  title: TextFormField(
                    focusNode: focus,
                    controller: commentcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      floatingLabelStyle: const TextStyle(color: Colors.red),
                      labelText: 'Comment',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white38,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red[400]!),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: focus.hasFocus ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          commentController.postComment(commentcontroller.text);
                          commentcontroller.text = '';
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
