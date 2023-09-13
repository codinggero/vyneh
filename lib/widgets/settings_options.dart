// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class settingsMenu extends StatelessWidget {
  const settingsMenu({
    Key? key, this.title, this.onTap, this.icn,this.subtxt
  }) : super(key: key);
 final title;
 final onTap;
 final icn;
 final subtxt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0),
      child: ListTile(
        onTap:onTap,
        trailing: Icon(icn),
        subtitle: Text('$subtxt',style: const TextStyle(fontSize: 18,fontFamily: 'Poppins'),) ,
        title:  Text('$title',
        style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),),
        
      ),
    );
  }
}

class settingsToggleMenu extends StatefulWidget {

   settingsToggleMenu({
    Key? key, this.title, this.onTap, this.icn,this.subtxt,required this.notification
  }) : super(key: key);
 final title;
 final onTap;
 final icn;
 final subtxt;
 bool notification = false;

  @override
  State<settingsToggleMenu> createState() => _settingsToggleMenuState();
}

class _settingsToggleMenuState extends State<settingsToggleMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0),
      child: SwitchListTile(
       value: widget.notification,
       onChanged: ( value){
        setState((){
          widget.notification = value;
        });
       },
        subtitle: Text('${widget.subtxt}',style: const TextStyle(fontSize: 18,fontFamily: 'Poppins'),) ,
        title:  Text('${widget.title}',
        style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),),
        
      ),
    );
  }
}