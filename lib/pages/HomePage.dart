import 'package:flutter/material.dart';
import 'package:to_do_app/Custom/TodoCard.dart';

import 'package:to_do_app/Service/Auth_Service.dart';
import 'package:to_do_app/pages/AddTodo.dart';
import 'package:to_do_app/pages/SignUpPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Today's Shedule",
        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/girl-s-face-with-beautiful-smile-female-avatar-website-social-network_499739-527.jpg"),
          ),
          SizedBox(
            width: 15,
          ),
      ],
      bottom: PreferredSize(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
            "Monday 21",
                style: TextStyle(
            fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,),
                ),
          ),
        ),
        
      preferredSize: Size.fromHeight(35)),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
            ),
           label: "home",
            ),
            BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddTodoPage()),);   
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.deepOrange,
                      Colors.orangeAccent,
                    ],)
                  ),
                     child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                     ),
                  ),
              ),
               label: "add",
            ),
              BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
            ),
            label: "setting",
            ),
            
      ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              TodoCard(
                title: "wake up",
                check: true,
                iconBgColor: Colors.white,
                iconColor:Colors.red ,
                iconData: Icons.alarm,
                time:"10 am" ,


              ),
              SizedBox(
                height: 15,
              ),
               TodoCard(
                title: "let's go gym",
                check: true,
                iconBgColor: Colors.white,
                iconColor:Colors.red ,
                iconData: Icons.alarm,
                time:"10 am" ,


              ),
               SizedBox(
                height: 15,
              ),
               TodoCard(
                title: "Buy some food",
                check: true,
                iconBgColor: Colors.white,
                iconColor:Colors.red ,
                iconData: Icons.alarm,
                time:"10 am" ,


              ),
               SizedBox(
                height: 15,
              ),
               TodoCard(
                title: "Testing something",
                check: true,
                iconBgColor: Colors.white,
                iconColor:Colors.red ,
                iconData: Icons.alarm,
                time:"10 am" ,


              ),
               SizedBox(
                height: 15,
              ),
               
            ],
          ),
        ),
      ),
     
    );
  }
}

// IconButton(
              //icon: Icon(Icons.logout),
              //onPressed: () async {
              // await authClass.logout();
                // Navigator.pushAndRemoveUntil(
                 //   context,
                 ///   MaterialPageRoute(builder: (builder) => SignupPage()),
                 //   (route) => false);
             // }),
