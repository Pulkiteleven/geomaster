import 'package:flutter/material.dart';
import 'package:geomaster/Auth/Login.dart';

import '../Usefull/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



String email = "";
String password = "";
String cpassword = "";

final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  bool isHide = false;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

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
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0,),
                      mainText("Signup", mainRed, 40.0, FontWeight.bold, 1),
                      mainText("SignUp to continue", textColor, 13, FontWeight.normal, 1),

                      SizedBox(height: 70.0,),

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
                      SizedBox(height: 15.0,),
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

                      SizedBox(height: 15.0,),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLength: 18,
                        style: TextStyle(
                            color: lightText,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
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
                          cpassword = text;
                        },
                        validator: (value) {
                          if(cpassword != password){
                            return("Both passwords must be same");
                          }
                        },
                      ),

                      SizedBox(height: 10.0,),

                      Row(
                        children: [
                          Spacer(),
                          btnsss("SignUp", () {signup(context);})
                        ],
                      ),

                      SizedBox(height: 30,),

                      Row(
                        children: [
                          Spacer(),
                          mainText("Alreay have an Account?", textColor, 13.0, FontWeight.normal, 1),
                          TextButton(
                              onPressed: (){
                                gologIn();
                              },
                              child: mainText("logIn", mainRed, 13.0, FontWeight.normal, 1)),
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
              Visibility(
                  visible: isHide,
                  child: loader()),
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

   signup(BuildContext context) async{
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      try{
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password)
            .then((value) => {
          print("blueee" + value.toString()),
          navScreen(logIn(up: true,), context, true),

        });
      } on FirebaseAuthException catch(e){
        if(e.code == "email-already-in-use"){
          setState((){
            isHide = false;
            snacker("User Already Exists", _messangerKey);
          });
        }
        else{
          setState((){
            isHide = false;
          });

          snacker("Something Went Wrong", _messangerKey);
        }
      }
    }
   }

  void gologIn() {
    navScreen(logIn(up:false), context, true);
  }
}
