import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/comons/colors.dart';
import 'package:human_talk/models/post/post.dart';
import 'package:human_talk/screens/homeScreen/components/PopUpMenuItems.dart';

class CardPost extends StatelessWidget {
  CardPost({ Key? key, this.posts, this.user}) : super(key: key);

  final Posts? posts;
  final String? user;

  

  @override
  Widget build(BuildContext context) {

    Future<void> onDelete(String id)async {
      await FirebaseFirestore.instance.collection('posts').doc(id).delete();
    }

    return Card(
      elevation: 6.0,
      color: ConstColors.fromHex(posts!.color!),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white,),
                    SizedBox(width: 4,),
                    Text(posts!.user?? 'User', style: TextStyle(fontSize: 12.0, color: Colors.white,),)
                  ],
                ),

                if(user == posts!.user)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.white,),
                    itemBuilder: (BuildContext context){
                      return Constants.choices.map((String choice){
                          return PopupMenuItem<String>(
                            value: choice,
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  if(choice == Constants.edit)
                                    Icon(Icons.edit, size: 12.0, color: Color(0xff0786CE) ,),
                                  if(choice == Constants.trash)
                                    Icon(Icons.delete_rounded, size: 12.0, color: Color(0xff0786CE) ,),
                                  SizedBox(width: 8,),
                                  Text(choice, style: TextStyle(color: Color(0xff0786CE), fontSize: 12.0, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              onTap: (){
                              if(choice == Constants.edit){
                                Navigator.of(context).pushNamed('/post', arguments: posts);
                                
                              }else if(choice == Constants.trash){
                                print(posts!.id);
                                onDelete(posts!.id!);
                              }
                            },
                            ),
                            
                          );
                      }).toList();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12,),
            Text(
              posts!.title ?? 'Hello World',
              style: TextStyle(
                fontSize: 40, 
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 12,),
            Text(
              posts!.content ?? 'Hello World Hello World Hello World Hello World Hello World Hello World',
              style: TextStyle(
                fontSize: 18, 
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_cafe_outlined, color: Colors.white,),
                    SizedBox(width: 4,),
                    Text('${posts!.coffee ?? 2}', style: TextStyle(fontSize: 12.0, color: Colors.white,),)
                  ],
                ),
                Icon(
                  Icons.ios_share, color: Colors.white,
                ),
                
              ],
            ),
          ],
        ),
      ),

    );
  }
}