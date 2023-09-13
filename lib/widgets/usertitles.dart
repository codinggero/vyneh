// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class UserTitles extends StatelessWidget {
  const UserTitles({
    Key? key, this.title,
  }) : super(key: key);
final title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:22.0,right: 15, top: 10, bottom: 5),
      child: Text('$title',style: const TextStyle(
        color: Color(0xffDDDDDD),
        fontFamily:'Poppins',
        fontSize: 18, ),),
    );
  }
}
class UserDescription extends StatelessWidget {
  const UserDescription({
    Key? key, required this.text, required this.icon,this.onpress,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final VoidCallback? onpress;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        children: [
          InkWell(
            onTap: onpress,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white54)
                ),
                child: ListTile(
                  title: Text(text, style: const TextStyle(
                  color: Color(0xffBDBDBD),
                  fontFamily:'Poppins',
                  fontSize: 16, ) ),
                  trailing: icon,
                  dense: true,
                ),
              ),
            ),
          ),
        ],
      )

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children:  [
      //   Text(text,style: const TextStyle(
      //     color: Color(0xffBDBDBD),
      //     fontFamily:'Poppins',
      //   fontSize: 16, ),),
      // ],),
    );
  }
}