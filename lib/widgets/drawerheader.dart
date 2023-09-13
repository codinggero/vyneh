// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:vyneh/package.dart';

class drawerHeader extends StatelessWidget {
  const drawerHeader({
    Key? key,
    required this.name,
    required this.address,
    this.img,
  }) : super(key: key);
  final String name;
  final String address;
  final img;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 20.0),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(Assets.drawable.pic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Text(
            name,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 21, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Text(
            address,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 19, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
