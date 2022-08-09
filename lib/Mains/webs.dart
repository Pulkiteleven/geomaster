import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class webs extends StatefulWidget {
  String weburl;
  webs({Key? key,required this.weburl}) : super(key: key);

  @override
  State<webs> createState() => _websState();
}

class _websState extends State<webs> {
  late WebViewController _viewController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: WebView(
            initialUrl: widget.weburl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _viewController = controller;
            },
          ),
        ),
      ),
    );
  }
}