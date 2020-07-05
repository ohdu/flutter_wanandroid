import 'package:flutter/material.dart';

class ToastUtil {
  static showSnackBar(GlobalKey<ScaffoldState> globalKey, String msg) {
    globalKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }
}
