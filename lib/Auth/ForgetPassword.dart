import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Usefull/Colors.dart';

final _messangerKey = GlobalKey<ScaffoldMessengerState>();

String email = "";

class forgetPassword extends StatefulWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {

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
                      mainText("Forget Password", mainRed, 40.0, FontWeight.bold, 1),
                      mainText("Enter email to continue", textColor, 13, FontWeight.normal, 1),

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


                      Row(
                        children: [
                          Spacer(),
                          btnsss("Reset Password", () {forgetPass();})
                        ],
                      ),

                      SizedBox(height: 30,),




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

   forgetPass()async {
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      try{
        await _auth.sendPasswordResetEmail(email: email)
            .then((value) => {
              snacker("Password Reset Link send Successfully",_messangerKey),
        setState((){
        isHide = false;
        }),
        });

      }
      on FirebaseAuthException catch(e){
        snacker(e.code, _messangerKey);
        setState((){
          isHide = false;
        });
      }
    }
   }
}
