import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'form.dart';

class FormController{
  String link;

  FormController(this.link);

  // Google App Script Web URL.
  // static const String URL = "https://script.google.com/macros/s/AKfycbxRGHSpGkBzb0gEblGHfDLtBhuE4dimEEM_z0y52lWXCHyTUh4mnKHiDt-DWSR4Yb8DWQ/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(Uri.parse(link), body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}