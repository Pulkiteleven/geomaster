import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geomaster/Auth/Forms.dart';
import 'package:geomaster/Auth/Login.dart';
import 'package:geomaster/Mains/HomeScreen.dart';
import 'package:geomaster/Usefull/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Scaffold(
      // body: mainForm(title: "Jobs",link:"feertger"),
      // body: logIn(),
      body: mainApp(),
    ),
  ));
}

class mainApp extends StatefulWidget {
  const mainApp({Key? key}) : super(key: key);

  @override
  State<mainApp> createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: mainRed,
        body: Center(
          child: logImg(MediaQuery.of(context).size.width * 0.50),
        ),
      ),
    );
  }

  @override
  void initState() {
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   navScreen(logIn(), context, true);
    // });
    Future.delayed(Duration(seconds: 2),(){
      getUser();
    });
  }

  getUser() async{

    User? user = await FirebaseAuth.instance.currentUser;

    if(user != null){
      navScreen(homeScreen(), context, true);
    }
    else if(user == null){
      navScreen(logIn(up:false), context, true);
    }
  }
}
