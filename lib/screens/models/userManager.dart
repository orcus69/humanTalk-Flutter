import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class  UserManager extends ChangeNotifier{

  late User user;
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> signIn({required email, required password, Function? onFail, Function? onSucces}) async {
    
    try {
      debugPrint(user.email);
      await auth.signInWithEmailAndPassword(email: email, password: password);

      onSucces!();
    } on PlatformException catch (e) {
      onFail!(e.code);
    }

  }
}