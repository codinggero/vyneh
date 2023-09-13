import 'package:flutter/material.dart';
import '/package.dart';

class Setting extends StatefulWidget {
  static String route = '/Setting';

  const Setting({super.key});

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            list('Account Security', Icons.settings_outlined, () {}),
            list('Language', Icons.language_outlined, () {}),
            list('Notification', Icons.notifications_outlined, () {
              Navigator.pushNamed(context, Notifications.route);
            }),
            list('Privacy Policy', Icons.privacy_tip_outlined, () {}),
          ],
        ),
      )).px(15),
    );
  }

  Padding list(String title, var leading, var tap) {
    return Card(
      child: ListTile(
        onTap: tap,
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Vx.gray300)),
          child: Icon(
            leading,
            color: Vx.gray400,
          ).p(10),
        ),
        title: Text(title).text.bold.make(),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    ).pOnly(bottom: 20);
  }
}
