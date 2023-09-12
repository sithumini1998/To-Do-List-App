import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:to_do_app/pages/HomePage.dart';
class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SigninPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Sign In", style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold,),),
        SizedBox(height: 20,),
        buttonitem("assets/google.svg","continue with Google" ,25),
        SizedBox(height: 15,),
        buttonitem("assets/phone.svg","continue with Mobile" ,25),
        SizedBox(height: 15,),
        Text("OR",style: TextStyle(color: Colors.white,fontSize: 16),),
        SizedBox(height: 15,),
        textitem("Email .....",_emailController,false),
        SizedBox(height: 15,),
        textitem("Password ....",_pwdController,true),
         SizedBox(height: 30,),
         colorButton(),
         SizedBox(height: 20,),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("If you don't have an Account? ",style: TextStyle(color: Colors.white,fontSize: 15)),
            Text("SignUp",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
          ],
         ),
          SizedBox(height: 15,),
         Text("Forgot Password?",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
      ],
      )
        )
      
      ),

    );
  }
  Widget colorButton(){
     return InkWell(
            onTap: () async {
              try{
                 firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user!.email);
           setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
              }catch(e){
                 final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
           setState(() {
            circular = false;
          });
              }
            },

       child: Container(
         width: MediaQuery.of(context).size.width -70,
            height: 60,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors:[ Color(0xfffd746c),
               Color(0xffff9068),
               Color(0xfffd746c)
              ])
            ),
            child:Center(
                child:circular?CircularProgressIndicator(): Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20),),
            )
           
       ),
     );
  }
  Widget buttonitem(String imgePath, String buttonName,double size){
    return  Container(
          width: MediaQuery.of(context).size.width -60,
          height: 60,
          child: Card(
            color: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            side:BorderSide(
              width: 1,color: Colors.deepPurple),
            ),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset(imgePath ,height:size, width:size,),
              SizedBox(width: 25,height: 25,),
              Text(buttonName,style: TextStyle(color:Colors.white,fontSize: 17),),
            ]
            ),
           ),
        );

  }
  Widget textitem(String labletext , TextEditingController controller,bool obscureText)
  {
    return Container(
        width: MediaQuery.of(context).size.width -70,
        height: 55,
        child: TextFormField(
             controller: controller,
             obscureText: obscureText,
             style:TextStyle(
              fontSize: 17,color: Colors.white), 

        decoration: InputDecoration(
            labelText: labletext ,
            labelStyle: const TextStyle(
              fontSize: 17,color: Colors.white
              ),
            focusedBorder:OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
                borderSide:const BorderSide(
                   width: 0.5,
                   color: Colors.amber
              ),
            ), 
            

            enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
                borderSide:const BorderSide(
                   width: 1,
                   color: Colors.red
              ),
            ),
           
          ),
          ),
    );
  }
}