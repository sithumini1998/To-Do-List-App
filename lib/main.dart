import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:to_do_app/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  void signUp()async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: "sithu@gmail.com", password: "123456");
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SignupPage(),
    );
  }
}