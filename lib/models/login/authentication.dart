import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/models/login/database.dart';
import 'package:human_talk/screens/homeScreen/HomeScreen.dart';

class Authentication {
  
  static Future<FirebaseApp> initializeFirebase(BuildContext context) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      saveUser(context, user);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;


    if (user != null) {
      saveUser(context, user);
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    
  }
}
