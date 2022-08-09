import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

Color mainRed = Color(0xFFEF5A55);

Color lightbtn = Color(0xFFE2E2E2);

Color darkmainRed = Color(0xFFFF6F6B);
Color textColor = Color(0xFF454545);
Color lightText = Color(0xFF636363);
Color errorColor = Color(0xFF00599C);
Color transparetn_overlay = Color(0xFFFFFF);
Color bottomNavigation = Color(0xFFE2E2E2);

Text mainText(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

AutoSizeText mainTextLines(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

Text mainTextLeft(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

Image logImg(double x){
  return Image(
    image: const AssetImage('assets/geologo.png'),
    width: x,
  );
}

Widget logImgt(double x){
  String url = "https://vdvtech.in/";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Image(
        image: const AssetImage('assets/trns.png'),
        width: x,
      ),
      TextButton(onPressed: (){
        launchUrl(Uri.parse(url));
      },
          child:
      mainText("Powerd by VDV", mainRed, 13, FontWeight.normal, 1))
    ],
  );
}

navScreen(Widget a,BuildContext context,bool replace){
  if(replace){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:
        (context){
      return a;
    }));
  }
  else {
    Navigator.push(context, MaterialPageRoute(builder:
        (context) {
      return a;
    }));
  }
}

class btnsss extends StatelessWidget {
  final VoidCallback callback;
  final String title;

  const btnsss(this.title,this.callback);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: mainText(
            title, Colors.white, 15.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              mainRed),
          backgroundColor:
          MaterialStateProperty.all<Color>(mainRed),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.white)))),
      onPressed: callback,
    );
  }
}

class colorBtnss extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final Color color;

  const colorBtnss(this.title,this.callback,this.color);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: mainText(
            title, Colors.white, 15.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              color),

          backgroundColor:
          MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.white)))),
      onPressed: callback,
    );
  }
}


class loader extends StatelessWidget {
  const loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new Container(
        height: 90.0,
        width: 90.0,
        child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          elevation: 7.0,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: mainRed,
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}

void snacker(String title, GlobalKey<ScaffoldMessengerState> aa){

  aa.currentState!.showSnackBar(SnackBar
    (content: mainTextLeft(title, Colors.white, 15.0, FontWeight.normal, 2),
    backgroundColor: mainRed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}