import 'package:flutter/material.dart';

class  PhoneAuthPage extends StatefulWidget {
  const  PhoneAuthPage({super.key});

  @override
  State< PhoneAuthPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State< PhoneAuthPage> {
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
            ],
           ),
        ),
      ),
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
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
             child: Text(
              " send",
              style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold,),
            ),
          )
        ),
      ),
    );
  }
  
}