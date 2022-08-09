import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geomaster/Auth/Controller.dart';
import 'package:geomaster/Auth/Forms.dart';
import 'package:geomaster/Auth/Login.dart';
import 'package:geomaster/Auth/form.dart';
import 'package:geomaster/Usefull/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


String mainUrl = "";


String name = "";
String nummber = "";
String institiute = "";
String gender = "";
String city = "";
String course = "";
String note = "";

class opportunity extends StatefulWidget {
  const opportunity({Key? key}) : super(key: key);

  @override
  State<opportunity> createState() => _opportunityState();
}

class _opportunityState extends State<opportunity> {
  bool knowbool = false;
  bool isHide = true;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseDatabase.instance.reference();

  List<Widget> oItems = [];
  Map<dynamic, dynamic> allData = {};

  @override
  void initState() {
    readData();
  }

  void readData() {
    databaseReference.once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        setState(() {
          allData = dataSnapshot.value as Map<dynamic, dynamic>;
          updateData();
        });
        // print(allData);
      }
    });
  }

  updateData() {
    mainUrl = allData['mainLink'];
    print(mainUrl + "batman");
    for (var x in allData['opportunity']) {
      if (x != null) {
        String name = x['title'];
        String link = allData['mainLink'];

        String desc = x['description'];

        var a = listItems(title: name, url: link, desc: desc);
        setState(() {
          isHide = false;
          if(x['status']){
            oItems.add(a);
            oItems.add(SizedBox(
              height: 10.0,
            ));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    mainText(
                        "Opportunities", mainRed, 40.0, FontWeight.bold, 1),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    mainText("Our Opportunities", textColor, 13.0,
                        FontWeight.normal, 1),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: oItems,
                )
              ],
            ),
          ),
          Visibility(
            visible: isHide,
            child: new Container(
              alignment: Alignment.center,
              child: new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: new Card(
                  color: transparetn_overlay,
                  elevation: 4.0,
                ),
              ),
            ),
          ),
          Visibility(visible: isHide, child: loader())
        ],
      ),
    );
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
                            "Know More", Colors.white, 10.0, FontWeight.normal, 1),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(mainRed),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(mainRed),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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

