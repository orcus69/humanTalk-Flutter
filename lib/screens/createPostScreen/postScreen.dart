import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/comons/colors.dart';
import 'package:human_talk/models/post/post.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key, this.posts}) : super(key: key);

  final Posts? posts;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();

  final TextEditingController content = TextEditingController();

  String _color = '#FF7A00';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print(currentUser.uid);
    }

      title.text = widget.posts!.title ?? '';
      content.text = widget.posts!.content ?? '';
    

    Future<void> createPost() async {
      setState(() {
        _loading = true;
      });
      await FirebaseFirestore.instance.collection('posts').doc(widget.posts!.id).set({
        'title': title.text,
        'content': content.text,
        'coffe': 0,
        'color':  _color,
        'user': currentUser!.email,
      }).then((value) {
        setState(() {
          _loading = false;
        });
        return Navigator.of(context).popAndPushNamed('/home');
      });
      
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 47),
                Text(
                  'Fale alguma coisa também!',
                  style: TextStyle(
                      fontSize: 40,
                      color: ConstColors.orange,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 32,
                ),
                Card(
                  elevation: 6.0,
                  color: Color(0xffF5F5F5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: title,
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'Título',
                              hintStyle: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff615B57))),
                        ),
                        TextFormField(
                          controller: content,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'Lança a braba...?',
                              hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff615B57)),
                              enabled: true,
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Escolhe um cor aí',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff615B57)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: ConstColors.orange,
                                border: Border.all(
                                    color: ConstColors.fromHex(_color) !=
                                            ConstColors.orange
                                        ? Colors.transparent
                                        : Colors.blue, // set border color
                                    width: 3.0), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    5.0)), // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey,
                                      offset: Offset(4, 4))
                                ] // make rounded corner of border
                                ),
                          ),
                          onTap: () => setState(() {
                            _color = '#FF7A00';
                          }),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: ConstColors.green,
                                border: Border.all(
                                    color: ConstColors.fromHex(_color) !=
                                            ConstColors.green
                                        ? Colors.transparent
                                        : Colors.blue, // set border color
                                    width: 3.0), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    5.0)), // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey,
                                      offset: Offset(4, 4))
                                ] // make rounded corner of border
                                ),
                          ),
                          onTap: () => setState(() {
                            _color = '#19B200';
                          }),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: ConstColors.blue,
                                border: Border.all(
                                    color: ConstColors.fromHex(_color) !=
                                            ConstColors.blue
                                        ? Colors.transparent
                                        : Colors.blue, // set border color
                                    width: 3.0), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    5.0)), // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                      color: Colors.grey,
                                      offset: Offset(4, 4))
                                ] // make rounded corner of border
                                ),
                          ),
                          onTap: () => setState(() {
                            _color = '#00C2FF';
                          }),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ConstColors.orange,
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () => createPost(),
                    child:_loading ? CircularProgressIndicator(color: Colors.white,) : Text('Postar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
