import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geomaster/Auth/Controller.dart';
import 'package:geomaster/Auth/Forms.dart';
import 'package:geomaster/Auth/Login.dart';
import 'package:geomaster/Auth/form.dart';
import 'package:geomaster/Mains/Opportunity.dart';
import 'package:geomaster/Mains/Survry.dart';
import 'package:geomaster/Usefull/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

String mainUrl = "";

final _messangerKey = GlobalKey<ScaffoldMessengerState>();

String name = "";
String nummber = "";
String institiute = "";
String gender = "";
String city = "";
String course = "";
String note = "";

List bottomItems = [];

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool knowbool = false;
  bool isHide = true;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseDatabase.instance.reference();

  List<Widget> oItems = [];
  Map<dynamic, dynamic> allData = {};
  int _currentindex = 0;

  @override
  void initState() {
    setState(() {
      bottomItems = [opportunity(), survey()];
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: mainRed,
            elevation: 0,
            actions: <Widget>[
              PopupMenuButton(
                  icon: Icon(MaterialIcons.more_vert),
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(

                      onTap: () {
                        setState(() {
                          isHide = true;
                        });
                        _auth.signOut().then((value) =>
                        {
                          setState(() {
                            isHide = false;
                            navScreen(logIn(up:false), context, true);
                          })
                        });
                      },
                      value: 0,
                      child: mainText(
                          "Logout", textColor, 13.0, FontWeight.normal, 1),
                    )
                  ]
              )
            ],

          ),
          bottomNavigationBar: Material(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
              color: bottomNavigation,
              child: SalomonBottomBar(
                currentIndex: _currentindex,

                onTap: (i) {
                  setState(() {
                    _currentindex = i;
                  });
                },

                items: [
                  SalomonBottomBarItem(icon: Icon(MaterialIcons.star_border,),
                      title: mainTextLines("Opportunities", textColor, 10.0,
                          FontWeight.normal, 1),
                      selectedColor: mainRed
                  ),
                  SalomonBottomBarItem(icon: Icon(MaterialIcons.view_comfy,),
                      title: mainTextLines("Survey", textColor, 10.0,
                          FontWeight.normal, 1),
                      selectedColor: mainRed
                  )
                ],
              ),
            ),
          ),
          body: bottomItems.elementAt(_currentindex)

      ),
    );
  }

  ApplyNow() async {
    // if (formKey.currentState!.validate()) {
    //   FeedbackForm form = FeedbackForm(name, user!.email.toString(), nummber,
    //       gender, city, institiute, course);
    //
    //   FormController formController = FormController();
    //
    //   setState(() {
    //     isHide = true;
    //   });
    //
    //   formController.submitForm(form, (String response) {
    //     print("Response: $response");
    //     if (response == FormController.STATUS_SUCCESS) {
    //       // Feedback is saved succesfully in Google Sheets.
    //       snacker("Succesfully Applied", _messangerKey);
    //       setState(() {
    //         isHide = false;
    //       });
    //     } else {
    //       // Error Occurred while saving data in Google Sheets.
    //       snacker("Something went wrong", _messangerKey);
    //
    //       setState(() {
    //         isHide = false;
    //       });
    //     }
    //   });
    // }
  }
}

class listItems extends StatelessWidget {
  String title;
  String url;
  String desc;

  listItems(
      {Key? key, required this.title, required this.url, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: ElevatedButton(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
            // child: Row(
            //   children: [
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainText(title, textColor, 15.0, FontWeight.normal, 1),
                    mainTextLines(desc, lightText, 10.0, FontWeight.normal, 3),
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: mainText(
                            "Know More", Colors.white, 10.0, FontWeight.normal,
                            1),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(mainRed),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(mainRed),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ))),
                      onPressed: () {
                        navScreen(
                            mainForm(title: title, link: url), context, false);
                      },
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            //     Spacer(),
            //     ElevatedButton(
            //       child: Padding(
            //         padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
            //         child: Row(
            //           children: [
            //             mainText(
            //                 "Know More", Colors.white, 5.0, FontWeight.normal,1),
            //             SizedBox(width: 3.0,),
            //           ],
            //         ),
            //       ),
            //       style: ButtonStyle(
            //           foregroundColor:
            //           MaterialStateProperty.all<Color>(
            //               mainRed),
            //           backgroundColor:
            //           MaterialStateProperty.all<Color>(mainRed),
            //           shape: MaterialStateProperty.all<
            //               RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius:
            //                 BorderRadius.circular(20.0),))),
            //       onPressed: (){
            //         navScreen(mainForm(title: title, link: url), context, false);
            //       },
            //     ),
            //
            //   ],
            // ),
          ),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(lightbtn),
              backgroundColor: MaterialStateProperty.all<Color>(lightbtn),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.white)))),
          onPressed: () {
            // payNow();
          }),
    );
  }
}
