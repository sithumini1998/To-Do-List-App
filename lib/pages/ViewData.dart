import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ViewData extends StatefulWidget {
  //const ViewData ({super.key ,required this.document});
  const ViewData ({super.key,required this.document,required this.id});
  final  Map<String,dynamic>document;
  final String id;

  @override
  State<ViewData > createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ViewData > {
   late TextEditingController _titleController;
  
  late TextEditingController _descriptionController;
   late String type;
   late String category;
   bool edit=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title=widget.document["title"]==null?"Hello":widget.document["title"];
    _titleController=TextEditingController(text: title);
    _descriptionController=TextEditingController(text: widget.document["description"]);
    type=widget.document["task"];
    category=widget.document["Category"];
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Color(0xff1d1e26),
             Color(0xff252041),
          ])
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed:(){
                    Navigator.pop(context);
                  }, 
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                    ),
                  ),
                   Row(
                     children: [
                       IconButton(onPressed:(){
                         setState(() {
                           edit=!edit;
                         });
                       }, 
                  icon: Icon(
                        Icons.delete,
                        color:Colors.red,
                        size: 28,
                        ),
                  ),
                         IconButton(onPressed:(){
                         setState(() {
                           edit=!edit;
                         });
                       }, 
                  icon: Icon(
                        Icons.edit,
                        color:edit?Colors.red: Colors.white,
                        size: 28,
                        ),
                  ),
                     ],
                   ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: Column(
                   crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit?"Editing":
                      "View",
                    style: TextStyle(
                      fontSize: 33,color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                    ),
                    SizedBox(height: 8,),
                     Text("Your Todo",
                    style: TextStyle(
                      fontSize: 33,color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    ),
                    
                    SizedBox(height: 25,),
                    lable("Task Title"),
                    SizedBox(height: 12,),
                    title(),
                    SizedBox(height: 30,),
                    lable("Task Type"),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        taskSelect("Important",0xffff6d6e),
                        SizedBox(width: 20,),
                        taskSelect("Planned",0xff2bc8d9),
                      ],
                    ),
                      SizedBox(height: 25,),
                    lable("Description"),
                    SizedBox(height: 12,),
                    description(),
                    SizedBox(height: 25,),
                    lable("Category"),
                    SizedBox(height: 12,),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Food",0xffff6d6e),
                        SizedBox(width: 20,),
                        categorySelect("WorkOut",0xff234edb),
                        SizedBox(width: 20,),
                        categorySelect("work",0xff6557ff),
                        SizedBox(width: 20,),
                        categorySelect("Design",0xff2bc8d9),
                        SizedBox(width: 20,),
                        categorySelect("Run",0xfff29732),
                       
                      ],
                     
                    ),
                     SizedBox(height: 50,),
                     edit?button():Container(),
                    SizedBox(height: 30,),
                  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget button(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection('Todo').doc(widget.id).update({
          "title":_titleController.text,
          "task":type,
          "Category":category,
          "description":_descriptionController.text,
        });
        Navigator.pop(context);
        print("user add");
      },
      child: Container(
        height: 56,
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors:[
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ],),
        ),
        child: Center(child: Text("Update Todo",style:  TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),),),
      ),
    );
  }
  Widget description(){
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
           enabled: edit,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLength: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        contentPadding: EdgeInsets.only(
          left: 20,
          right: 20,
        ), 
        ),
      ),
    );
  }
  Widget taskSelect(String label,int color){
    return InkWell(
      onTap: edit?(){
        setState(() {
          type=label;
        });
      }:null,
      child: Chip(
        backgroundColor:type==label?Colors.white: Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(  10,)),
        label:Text(label),
        labelStyle:TextStyle(
            color:type==label?Colors.black: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
    
          ) ,
          
          labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.7),
          ),
      
    );
    print("task work");
  }
  Widget categorySelect(String label,int color){
    return InkWell(
      onTap:edit? (){
         setState(() {
          category=label;
        });
      }:null,
      child: Chip(
        backgroundColor:category==label?Colors.white: Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(  10,)),
        label:Text(label),
      labelStyle:TextStyle(
            color:category==label?Colors.black:  Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
    
          ) ,
          
          labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.7),
          ),
    );
  }
  Widget title(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        contentPadding: EdgeInsets.only(
          left: 20,
          right: 20,
        ), 
        ),
      ),
    );
  }
  Widget lable(String lable){
    return  Text(
      lable,
      style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0.2,
      ),
    );
  }
}