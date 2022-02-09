import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/comons/colors.dart';
import 'package:human_talk/models/login/database.dart';
import 'package:human_talk/models/post/post.dart';
import 'package:human_talk/screens/homeScreen/components/card_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

    
}

class _HomeScreenState extends State<HomeScreen> {
  List<Posts> posts = [];

  @override
  void initState() {
    super.initState();
    loadPosts().then((result) {
      setState(() {
        posts = result;
      });
    }).catchError((onError) {
      setState(() {
        posts = [];
      });
    });
  }
  

  Widget renderPosts(User user) {
    final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance.collection('posts').snapshots();

    if (posts.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: Color(0xffFF7A00)));
    } else {

      return StreamBuilder<QuerySnapshot>(
          stream: _postsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return  const Text('Erro na consulta');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xffFF7A00)));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                final post = Posts.fromDocument(document);
                
                return CardPost(posts: post, user: user.email,);
              }).toList(),
            );
          },
        );
      
    }
  }

  @override
  Widget build(BuildContext context) {

    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print(currentUser.uid);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:47),
            Text(
              'Humanos estão Falano...', 
              style: TextStyle(
                fontSize: 40, 
                color: ConstColors.orange,
                fontWeight: FontWeight.bold
              ),
            ), 
            SizedBox(height: 12,),
            GestureDetector(
              child: Text('Sair', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red,),),
              onTap: () async {
                return await FirebaseAuth.instance.signOut()
                            .then((value) => Navigator.of(context)
                            .popAndPushNamed('/login'));
              },
            ),

            Expanded(
              child: renderPosts(currentUser!),
            ),
            
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => 
          Navigator.of(context)
          .pushNamed("/post", arguments: Posts('', '', '', 0, '')),
        backgroundColor: ConstColors.orange,
        child: Icon(Icons.post_add_rounded),
      ),
    );
  }
}

