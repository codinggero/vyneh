import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator {
  static bool state = false;

  static Future call(response, {required BuildContext context}) async {
    if (response == true && state == false) {
      state = true;
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(),
            ),
          ),
        ),
      );
    } else if (response == false && state == true) {
      state = false;
      Navigator.of(context).pop();
    }
  }
}
