// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';

class drawerMenu extends StatelessWidget {
  const drawerMenu({
    Key? key, this.title, this.onpress, this.trailingIcon, this.leading
  }) : super(key: key);
 final title;
 final VoidCallback? onpress;
 final trailingIcon;
 final leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title:  Text('$title',style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),),
      trailing: trailingIcon,
      onTap:onpress,
    );
  }
}

class Tile2 extends StatelessWidget {
  const Tile2({
    Key? key, this.title, this.onTap, this.Subtitle, this.Trailing, this.leading
  }) : super(key: key);
 final title;
 final VoidCallback? onTap;
 final Subtitle;
 final Trailing;
 final leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title:  Text('$title',style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
      onTap:onTap,
      subtitle: Subtitle,
      // Text('$Subtitle',style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),),
      trailing: Trailing,
    );
  }
}