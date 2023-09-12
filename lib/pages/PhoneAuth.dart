import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class  PhoneAuthPage extends StatefulWidget {
  const  PhoneAuthPage({super.key});

  @override
  State< PhoneAuthPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State< PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
         backgroundColor: Colors.black87,
            title: Text(
          "SignUp",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
          centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
           child: Column(
            children: [
               SizedBox(
                height: 120,
              ),
             textfield(),
              SizedBox(
                height: 10,
              ),
             Container(
              width: MediaQuery.of(context).size.width -34,
              child: Row(
                 children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                       margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                   Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                  ),
                 ],

              ),
             ),
              SizedBox(
                height: 30,
              
              ),
              otpfield(),
              SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                   children: [
                      TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                  ),
                  TextSpan(
                    text: " sec ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
                  ),
                   ],
                ),
              ),
               Container(
              height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: Color(0xffff9601),
                      borderRadius: BorderRadius.circular(15)),
                      child: Center(
                         child: Text(
                      "Lets Go",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xfffbe2ae),
                          fontWeight: FontWeight.w700),
                    ),
                      ),
            ),
            ],
           
           ),
        ),
      ),
    );
  }
  void startTimer(){
      const onsec = Duration(seconds: 1);
      Timer timer=Timer.periodic(onsec, (timer) { 
         if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
      });
  }
  Widget otpfield(){
    return OTPTextField(
  length: 6,
  width: MediaQuery.of(context).size.width -34,
  fieldWidth: 45,
  otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
  style: TextStyle(
    fontSize: 17,color: Colors.white
  ),
  textFieldAlignment: MainAxisAlignment.spaceAround,
  fieldStyle: FieldStyle.underline,
  onCompleted: (pin) {
    print("Completed: " + pin);
  },
);  
}
  Widget textfield(){
    return Container(
      width: MediaQuery.of(context).size.width - 40,
        height: 60,
      decoration: BoxDecoration(
             color:   Color.fromARGB(255, 72, 70, 70),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
           border: InputBorder.none,
           hintText: "Enter your phone Number",
          hintStyle: TextStyle(color: Colors.white54, fontSize: 15),
          contentPadding:const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+94) ",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
           suffixIcon: InkWell(
            onTap:wait?null:()async {
              startTimer();
                setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Resend";
                    });
            },
             child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
             child: Text(
              buttonName,
              style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold,),
            ),
          )
           ),
         
        ),
      ),
    );
  }
  
}