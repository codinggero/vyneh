import 'package:flutter/material.dart';
import '/package.dart';

class PasswordUpdate extends StatefulWidget {
  static String route = '/PasswordUpdate';

  const PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => PasswordUpdateState();
}

class PasswordUpdateState extends State<PasswordUpdate> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirmation = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void onPressed() {
    api.request.passwordUpdate(
      oldPassword: oldPassword.text,
      newPassword: newPassword.text,
      newPasswordConfirmation: newPasswordConfirmation.text,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Navigator.pop(context);
      },
      onError: (err) {
        if (err.runtimeType == Res) {
          Snackbar.error(context, message: err.message);
        } else {
          Snackbar.error(context, message: err);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: const Text(
            'Change Password',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          // Text('Current Password').text.bold.size(20).make(),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Enter Password',
          //     border: OutlineInputBorder()
          //   ),
          // ).py12(),
          const Text(
            'Old Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: oldPassword,
            decoration: InputDecoration(
              hintText: 'Old Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ).py12(),
          const Text(
            'New Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: newPassword,
            decoration: InputDecoration(
              hintText: 'Old New Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ).py12(),
          const Text(
            'Re-enter Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: newPasswordConfirmation,
            decoration: InputDecoration(
              hintText: 'Re-enter Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ).py12(),
        ],
      ).px20(),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: const Text('Change Password')
            .text
            .white
            .bold
            .size(20)
            .make()
            .centered(),
      ).py12().px(20).onTap(onPressed),
    );
  }
}
