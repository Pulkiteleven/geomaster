
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geomaster/Auth/form.dart';
import 'package:geomaster/Mains/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Usefull/Colors.dart';
import 'Controller.dart';
import 'package:flutter_icons/flutter_icons.dart';


String name = "";
String number = "";
String email = "";

String instiute = "";
String Course = "";
String education = "";

String companyName = "";

String Message = "";

final jobKey = GlobalKey<FormState>();
final associatekey = GlobalKey<FormState>();
final formKey = GlobalKey<FormState>();


List<String> subjectItems = ["Lookong for a Job",
  "Wanted to be Associated with GeoMaster",
  "Want to know about current ongoing Project"];

List<String> jobItems = ["Telecalling","Field Executive","Micro Service","Other"];


final _messangerKey = GlobalKey<ScaffoldMessengerState>();

class mainForm extends StatefulWidget {
  String title;
  String link;
  mainForm({Key? key,required this.title,required this.link}) : super(key: key);

  @override
  State<mainForm> createState() => _mainFormState();
}

class _mainFormState extends State<mainForm> {
  double size = 10.0;
  bool knowbool = false;
  bool isHide = false;
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String subject = subjectItems[0];
  String jobType = jobItems[0];

  int selecteditem = 2;

  bool lookingforjob = false;
  bool assocaited = false;


  List<Widget> allSubjects = [];


  @override
  void initState() {
    // setHidden();
    setState((){
      email = user!.email.toString();
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainRed,
          leading: IconButton(
            icon: Icon(MaterialIcons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
          body: SafeArea(
            child:
            Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0,),
                      mainTextLines(
                          widget.title, mainRed, 40.0, FontWeight.bold, 1),
                      mainText(
                          "Opportunities", textColor, 13, FontWeight.normal, 1),
                      SizedBox(height: 15.0,),

                      Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  maxLength: 30,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.person,color: mainRed,),
                                    labelText: "Full Name",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    name = text;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return ("Please Enter a Name");
                                    }
                                  },
                                ),

                                SizedBox(height: 10.0,),

                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.phone,color: mainRed),

                                    labelText: "Mobile Number",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    number = text;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return ("Please Enter a Number");
                                    }
                                  },
                                ),

                                SizedBox(height: 10.0,),

                                TextFormField(
                                  controller: TextEditingController(text: email),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 48,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.mail,color: mainRed),
                                    labelText: "Email Id",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    email = text;
                                  },
                                  validator: (value) {
                                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                                    if(!emailValid){
                                      return("Please enter a valid email");
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                ),

                                SizedBox(height: 10.0,),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              mainText("Select Subject", textColor, 15.0, FontWeight.normal, 1),
                              Spacer(),
                            ],
                          ),
                          DropdownButton(
                            isExpanded: true,
                            value: subject,
                            icon: Icon(CupertinoIcons.down_arrow,color: mainRed,),
                              items: subjectItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: mainText(value, lightText, 15.0, FontWeight.normal, 1),
                            );
                          }).toList(),
                              onChanged: (String? value){
                                setState((){
                                  subject = value.toString();
                                  selecteditem = subjectItems.indexOf(value!);
                                  if(selecteditem == 0){
                                    lookingforjob = true;
                                    assocaited = false;
                                  }
                                  else if(selecteditem == 1){
                                    lookingforjob = false;
                                    assocaited = true;
                                  }
                                  else{
                                    lookingforjob = false;
                                    assocaited = false;
                                  }
                                });
                              }),
                          SizedBox(height: 10.0,),

                          // allSubjects.elementAt(selecteditem),
                          Visibility(
                            visible: lookingforjob,
                            child:  Form(
                            key: jobKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLength: 56,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.building_2_fill,color: mainRed),
                                    labelText: "Institute",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    instiute = text;
                                  },
                                  validator: (value) {
                                    if(value!.isEmpty || value == null){
                                      return("Please Enter your Institute");
                                    }
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLength: 56,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.book,color: mainRed),
                                    labelText: "Course",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    course = text;
                                  },
                                  validator: (value) {
                                    if(value!.isEmpty || value == null){
                                      return("Please Enter your Course");
                                    }
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLength: 56,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 15.0,
                                      fontFamily: 'mons'),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(CupertinoIcons.bookmark,color: mainRed),
                                    labelText: "Highest Education",
                                    labelStyle: TextStyle(
                                      color: mainRed,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    errorStyle: TextStyle(
                                      color: errorColor,
                                      fontFamily: 'mons',
                                      fontSize: 15.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainRed),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: darkmainRed,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                  onChanged: (text) {
                                    education = text;
                                  },
                                  validator: (value) {
                                    if(value!.isEmpty || value == null){
                                      return("Please Enter your education");
                                    }
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  children: [
                                    mainText("Job Type", textColor, 15.0, FontWeight.normal, 1),
                                    Spacer(),
                                  ],
                                ),
                                DropdownButton(
                                    isExpanded: true,
                                    value: jobType,
                                    icon: Icon(CupertinoIcons.down_arrow,color: mainRed,),
                                    items: jobItems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: mainText(value, lightText, 15.0, FontWeight.normal, 1),
                                      );
                                    }).toList(),
                                    onChanged: (String? value){
                                      setState((){
                                        jobType = value.toString();
                                        print(value);
                                      });
                                    }),

                              ],
                            ),
                          ),),

                          Visibility(
                            visible: assocaited,
                            child: Form(
                              key: associatekey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLength: 56,
                                    style: TextStyle(
                                        color: lightText,
                                        fontSize: 15.0,
                                        fontFamily: 'mons'),
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(CupertinoIcons.building_2_fill,color: mainRed),
                                      labelText: "Company Name",
                                      labelStyle: TextStyle(
                                        color: mainRed,
                                        fontFamily: 'mons',
                                        fontSize: 15.0,
                                      ),
                                      errorStyle: TextStyle(
                                        color: errorColor,
                                        fontFamily: 'mons',
                                        fontSize: 15.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: mainRed),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: darkmainRed,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: errorColor,
                                        ),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      companyName = text;
                                    },
                                    validator: (value) {
                                      if(value!.isEmpty || value == null){
                                        return("Please Enter your Company Name");
                                      }
                                    },
                                  ),
                                ],
                              )),),

                          SizedBox(height: 10.0,),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLength: 156,

                            style: TextStyle(
                                color: lightText,
                                fontSize: 15.0,
                                fontFamily: 'mons'),
                            decoration: InputDecoration(
                              suffixIcon: Icon(CupertinoIcons.chat_bubble,color: mainRed,),
                              labelText: "Message",
                              labelStyle: TextStyle(
                                color: mainRed,
                                fontFamily: 'mons',
                                fontSize: 15.0,
                              ),
                              errorStyle: TextStyle(
                                color: errorColor,
                                fontFamily: 'mons',
                                fontSize: 15.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainRed),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: darkmainRed,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: errorColor,
                                ),
                              ),
                            ),
                            onChanged: (text) {
                              Message = text;
                            },
                          ),

                          SizedBox(height: 10.0,),

                          Row(
                            children: [
                              Spacer(),
                              btnsss("Apply Now", () {
                                ApplyNow();
                              })
                            ],
                          )

                        ],
                      )

                    ],
                  ),
                ),

                Visibility(
                  visible: isHide,
                  child: new Container(
                    alignment: Alignment.center,
                    child: new Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: new Card(
                        color: transparetn_overlay,
                        elevation: 4.0,
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: isHide,
                    child: loader())
              ],
            ),
          )
      ),
    );
  }

  ApplyNow() async {
    if (formKey.currentState!.validate()) {
      if(lookingforjob){
        if(jobKey.currentState!.validate()){
          print("jobs");
          FeedbackForm form = FeedbackForm(name, email, number, subject,
              instiute, course, education, jobType,
              "", Message,widget.title);
          SubmitForm(form,1);
        }
      }
      else if(assocaited){
        if(associatekey.currentState!.validate()){
          print("associatted");
          FeedbackForm form = FeedbackForm(name, email, number, subject,
              "", "", "", "",
              companyName, Message,widget.title);
        SubmitForm(form,2);
        }
      }
      else{
        print("ongoing");
        FeedbackForm form = FeedbackForm(name, email, number, subject,
            "", "", "", "",
            "", Message,widget.title);
        SubmitForm(form,0);
      }
    }
  }

  SubmitForm(FeedbackForm f,int a){

    FormController formController = FormController(widget.link);
    setState(() {
      isHide = true;
    });

    formController.submitForm(f, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        snacker("Succesfully Applied", _messangerKey);
        setState(() {

          formKey.currentState!.reset();
          if(a==1) {
            jobKey.currentState!.reset();
          }
          else if(a==2){
            associatekey.currentState!.reset();
          }

          isHide = false;

        });
      } else {
        // Error Occurred while saving data in Google Sheets.
        snacker("Something went wrong", _messangerKey);

        setState(() {
          isHide = false;
        });
      }
    });
  }



}
