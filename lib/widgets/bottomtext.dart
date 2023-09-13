// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


class BottomText extends StatelessWidget {
  const BottomText({
    Key? key, this.text,
  }) : super(key: key);
final text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
      Text('$text',style: const TextStyle(
        color: Colors.black,
        fontFamily:'Poppins',
         
      fontSize: 20, ),)
    ],);
  }
}
