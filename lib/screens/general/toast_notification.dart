import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastNotification {
  Future<bool?> showToast(String message, bool status) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: status ? Colors.greenAccent : Colors.red,
      textColor: status ? Colors.black : Colors.white,
    );
  }
}
