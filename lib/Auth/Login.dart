import 'package:flutter/material.dart';
import 'package:geomaster/Auth/SignUp.dart';
import 'package:geomaster/Mains/HomeScreen.dart';
import 'package:geomaster/Usefull/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ForgetPassword.dart';

String email = "";
String password = "";

final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class logIn extends StatefulWidget {
  bool up;
  logIn({Key? key,required this.up}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  bool isHide = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      mainText("Login", mainRed, 40.0, FontWeight.bold, 1),
                      mainText("login to continue", textColor, 13,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 70.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 50,
                        style: TextStyle(
                            color: lightText,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Email",
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
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (!emailValid) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLength: 18,
                        style: TextStyle(
                            color: lightText,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Password",
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
                          password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Password");
                          } else if (value.length < 6) {
                            return ("Password must have more than 6 characters");
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                forgetPass();
                              },
                              child: mainText("Forget Password?", mainRed, 15.0,
                                  FontWeight.normal, 1))
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          btnsss("Login", () {
                            login(context);
                          })
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          mainText("Didn't have an Account?", textColor, 13.0,
                              FontWeight.normal, 1),
                          TextButton(
                              onPressed: () {
                                goSignUp();
                              },
                              child: mainText("Sign Up", mainRed, 13.0,
                                  FontWeight.normal, 1)),
                          Spacer()
                        ],
                      )
                    ],
                  ),
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
              Visibility(visible: isHide, child: loader()),

              new Container(
                margin: EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.bottomCenter,
                child: new Container(
                  child: logImgt(MediaQuery.of(context).size.width * 0.30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if(widget.up) {
      snacker("User Created Succesfully", _messangerKey);
    }
  }

  void forgetPass() {
    navScreen(forgetPassword(), context, false);
  }

  login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isHide = true;
      });
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  navScreen(homeScreen(), context, true),
                  setState(() {
                    isHide = false;
                  }),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          setState(() {
            isHide = false;

          });
          snacker("User not Found", _messangerKey);
        } else if (e.code == "wrong_password") {
          setState(() {
            isHide = false;
          });
          snacker("Wronng Password", _messangerKey);
          print('hello');

        } else {
          setState(() {
            isHide = false;
          });
          snacker("Something went wrong", _messangerKey);
          print('hello');

        }
      }
    }
  }

  void goSignUp() {
    navScreen(signUp(), context, false);
  }
}
