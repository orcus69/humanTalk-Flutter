import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/models/post/post.dart';
import 'package:human_talk/screens/createPostScreen/postScreen.dart';
import 'package:human_talk/screens/homeScreen/HomeScreen.dart';
import 'package:human_talk/screens/loginScreen/LoginScreen.dart';
import 'package:human_talk/screens/models/userManager.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<UserManager>(
      create: (_) => UserManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: LoginScreen(),
        ),
        onGenerateRoute: (route){
          switch(route.name){
            case '/home':
              return MaterialPageRoute(
                builder: (_) => HomeScreen(),
              );
            case '/post':
              return MaterialPageRoute(
                builder: (_) => CreatePostScreen(
                  posts: route.arguments! as Posts
                )
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                  settings: route
              );
          }
        },
      ),
    );
  }
}