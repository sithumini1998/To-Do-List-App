import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/pages/HomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthClass{
  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final storage = new FlutterSecureStorage();
    Future<void> googleSignIn( BuildContext context) async {
      try{
         GoogleSignInAccount? googleSignInAccount = await  _googleSignIn.signIn();
           if(googleSignInAccount != null)
           {
             GoogleSignInAuthentication googleSignInAuthentication =  await googleSignInAccount.authentication;
             AuthCredential credential = GoogleAuthProvider.credential
             (
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken,
             );
               try{
                 UserCredential userCredential = await _auth.signInWithCredential(credential);
                 storeTokenAndData( userCredential);
                  Navigator.pushAndRemoveUntil(
                  context,
                   MaterialPageRoute(
                   builder: (builder) => HomePage()),
                  (route) => false);
               }catch(e){
                    final snackBar = SnackBar(content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
               }
            
           }else{
                 final snackBar = SnackBar(content: Text("not able to sign in"));
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }
      }
      catch(e)
      {
          final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    Future<void>storeTokenAndData(UserCredential userCredential) async {
      await storage.write(key:  "token", value: userCredential.credential?.token.toString());
      await storage.write(key: "usercredential", value: userCredential.toString());
    }
    Future<String?> getToken()async{
      return await storage.read(key: "token");
    }
    Future<void>logout()async{
       try{
          await _googleSignIn.signOut();
          await _auth.signOut();
          await storage.delete(key: "token");
       }catch(e){

      
       }
    }
}