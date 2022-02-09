import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document){
    id      = document.id;
    //uuid    = document.data['uid'] as String;
    name    = document.get('name') as String;
    email   = document.get('email') as String;
  }

  String? id;
  String? uuid;
  String? user;

  String? name;
  String? email;
  String? password;

 final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Acessa referencia do usuário no firestore
  DocumentReference get firestoreRef =>
    firestore.doc('users');

  CollectionReference get cartReference =>
    firestoreRef.collection('cart');

  CollectionReference get tokensReference =>
    firestoreRef.collection('tokens');
  //Seta dados do usuário


}