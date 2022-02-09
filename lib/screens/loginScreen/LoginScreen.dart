import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_talk/comons/colors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    
    //Login
    Future<void> login(email, password) async {
      setState(() {
        _loading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
        ).then((_) => Navigator.of(context).pushNamed("/home"))
        .catchError((_) => print('Preencha todos os campos'));
      } on FirebaseAuthException catch (e) {
        //TODO: ERRO DE LOGIN COM SNACKBAR
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      setState(() {
        _loading = false;
      });
    }

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:47),
                Text(
                  'Olá \nHumano!', 
                  style: TextStyle(
                    fontSize: 40, 
                    color: ConstColors.orange,
                    fontWeight: FontWeight.bold
                  ),
                ), 

                SizedBox(height: 105,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 17,),      
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email'
                            ),
                          ),
                          SizedBox(height: 60,),
                          TextFormField(
                            obscureText: true,
                            controller: passController,
                            decoration: InputDecoration(
                              hintText: 'Senha'
                            ),
                          ),
                          SizedBox(height: 48,),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ConstColors.orange,
                              minimumSize: Size.fromHeight(50)
                            ),
                            onPressed: ()=>login(emailController.text, passController.text), 
                            child: _loading ? CircularProgressIndicator(color: Colors.white,) : Text('Login')
                          )

                        ],
                      )
                    ),   
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}