import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:geomaster/Mains/webs.dart';

import '../Usefull/Colors.dart';


class survey extends StatefulWidget {
  const survey({Key? key}) : super(key: key);

  @override
  State<survey> createState() => _surveyState();
}

class _surveyState extends State<survey> {
  bool isHide = false;
  List<Widget> surveys = [];

  Image amazon = Image.asset('assets/amazon.jpg', fit: BoxFit.cover,);
  Image flipkart = Image.asset('assets/flupkart.jpg', fit: BoxFit.cover,);
  Image meesho = Image.asset('assets/meesho.jpg', fit: BoxFit.cover,);
  Image zomato = Image.asset('assets/zomato.jpg', fit: BoxFit.cover,);


  String zurl = "https://docs.google.com/forms/d/e/1FAIpQLSegVRYsEV2cJG7UHuTV0bakf24AvyP0Fy2DPUXi53JMOB_SBQ/viewform";
  String aurl = "https://docs.google.com/forms/d/e/1FAIpQLScCWGHZ_YAQb1n9HAwZU8U2ydBs26oOmUu2ijAcEpplnnO8uQ/viewform";
  String murl = "https://docs.google.com/forms/d/e/1FAIpQLScT-x5FwEyZpZ-144Wd21dDF63GfQvsdG32NOXsh2a2bP8i0w/viewform";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    mainText(
                        "Survery", mainRed, 40.0, FontWeight.bold, 1),
                    Spacer(),
                  ],
                ),
                Row(
                  children: [
                    mainText("Available Survey", textColor, 13.0,
                        FontWeight.normal, 1),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(

                            children: [
                              Spacer(),
                              surveyItems(title: "Zomato", img: zomato, callback: (){
                                navScreen(webs(weburl: zurl), context, false);
                              }),
                              SizedBox(width: 3.0,),

                              surveyItems(title: "Amazon", img: amazon, callback: (){
                                navScreen(webs(weburl: aurl), context, false);
                              }),
                              Spacer()

                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Spacer(),
                              surveyItems(title: "Flipkart", img: flipkart, callback: (){
                                navScreen(webs(weburl: aurl), context, false);
                              }),

                              SizedBox(width: 3.0,),
                              surveyItems(title: "Messho", img: meesho, callback: (){
                                navScreen(webs(weburl: murl), context, false);
                              }),
                              Spacer()
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
          Visibility(
            visible: isHide,
            child: new Container(
              alignment: Alignment.center,
              child: new Container(
                color: transparetn_overlay,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

              ),
            ),
          ),
          Visibility(visible: isHide, child: loader())
        ],
      ),
    );
  }

  @override
  void initState() {
    setState((){
      surveys = [
      surveyItems(title: "Zomato", img: zomato, callback: (){
      navScreen(webs(weburl: zurl), context, false);}),

        surveyItems(title: "Amazon", img: amazon, callback: (){
          navScreen(webs(weburl: aurl), context, false);
        }),
        surveyItems(title: "Flipkart", img: flipkart, callback: (){
          navScreen(webs(weburl: aurl), context, false);
        }),

        surveyItems(title: "Messho", img: meesho, callback: (){
          navScreen(webs(weburl: murl), context, false);
        }),

      ];
    });
  }

  openWeb(String web){
    navScreen(webs(weburl: web), context, false);
  }

}

class surveyItems extends StatelessWidget {
  String title;
  Image img;
  VoidCallback callback;
  surveyItems({Key? key,required this.title,required this.img,required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.45,
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: lightbtn,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.0,
                child: ClipOval(
                  child: img,
                ),
              ),
              SizedBox(height: 10.0,),
              mainText(title, textColor, 20.0, FontWeight.normal, 1),
              SizedBox(height: 10.0,),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: mainText(
                      "Apply Now", Colors.white, 10.0, FontWeight.normal, 1),
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
                onPressed: callback
              ),
            ],
          ),
        ),
      ),
    );
  }
}

