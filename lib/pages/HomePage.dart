import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  final Stream<QuerySnapshot>_stream=FirebaseFirestore.instance.collection('Todo').snapshots();
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
      body:StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context,index){
              IconData iconData;
              Color iconColor;
              Map<String,dynamic>document=snapshot.data?.docs[index].data() as Map<String,dynamic>;
              switch(document["Category"]){
                case "work:":
                iconData=Icons.run_circle_outlined;
                iconColor=Colors.white;
                break;
                case "WorkOut:":
                iconData=Icons.alarm;
                iconColor=Colors.red;
                 break;
                case "food:":
                iconData=Icons.local_grocery_store;
                iconColor=Colors.pink;
                break;
                case "Design:":
                iconData=Icons.audiotrack;
                iconColor=Colors.blue;
                default:
                iconData=Icons.run_circle_outlined;
                iconColor=Colors.yellow;
              }
            return 
           TodoCard(
                title: document['title'] == null
                ?"hello"
                :document['title'],
                check: true,
                iconBgColor: Colors.white,
                iconColor:iconColor ,
                iconData: iconData,
                time:"10 am" ,


              );
          });
        } ),
     
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
