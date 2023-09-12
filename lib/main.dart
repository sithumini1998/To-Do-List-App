import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:to_do_app/Service/Auth_Service.dart';
import 'package:to_do_app/pages/HomePage.dart';

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
 
  Widget currentPage = SignupPage();
  AuthClass authClass=AuthClass();
    @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }
  checkLogin()  async{
    String? tokne = await authClass.getToken();
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}