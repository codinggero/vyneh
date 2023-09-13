// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles(
      {super.key,
      required this.text,
      this.color,
      this.icon,
      this.subtitle,
      this.trainling,
      this.tap});

  final text;
  final color;
  final icon;
  final subtitle;
  final trainling;
  final tap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: color,
        child: icon,
      ),
      title: text,
      subtitle: subtitle,
      trailing: trainling,
    );
  }
}
