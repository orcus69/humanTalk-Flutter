import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/models/post/post.dart';

void saveUser(BuildContext context, User user) async {
  
  DocumentReference userDB =
      FirebaseFirestore.instance.collection('posts').doc(user.uid);

  await userDB.get().then((DocumentSnapshot doc) async {
    if (doc.exists) {
      return await userDB.update({
        'user': user.displayName,
      });
    } else {
      return await userDB.set({
        'user': user.displayName,
      });
    }
  });
}

Future<List<Posts>> loadPosts() async {
  CollectionReference recordsRef =
      FirebaseFirestore.instance.collection('/posts/');

  late final List<Posts> posts;

  await recordsRef.get().then((QuerySnapshot snapshot) {
    posts = snapshot.docs
        .map((doc) => Posts(
              doc['user'],
              doc['title'],
              doc['content'],
              doc['coffe'],
              doc['color']
            ))
        .toList();
  });

  return posts;
}
