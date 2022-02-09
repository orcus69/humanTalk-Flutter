import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  
  Posts(this.user, this.title, this.content, this.coffee, this.color);

  Posts.fromDocument(DocumentSnapshot document){
    id        = document.id;
    user      = document['user'] as String;
    title     = document['title'] as String;
    content   = document['content'] as String;
    coffee    = document['coffe'] as num;
    color     = document['color'] as String;
  }

  String? user;
  String? title;
  String? content;
  num? coffee;
  String? color;
  String? id;


}
