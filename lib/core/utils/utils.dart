import 'package:dairy_app/core/constants/exports.dart';

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.pinkAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
