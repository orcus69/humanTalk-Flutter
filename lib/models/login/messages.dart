import 'package:flutter/material.dart';
import 'package:human_talk/comons/colors.dart';

class Message {
  
  static void showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ConstColors.green,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }

  static void showError(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }
}
