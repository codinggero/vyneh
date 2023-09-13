import 'package:flutter/material.dart';
import '/package.dart';

class ChangePassword extends StatefulWidget {
  static String route = '/ChangePassword';

  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  dynamic arguments;
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments ?? {};
      setState(() {});
    });
  }

  void onChangePassword() {
    api.request.resetPassword(
      email: arguments['email'],
      password: password.text,
      passwordConfirmation: passwordConfirmation.text,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Navigator.popAndPushNamed(context, Splash.route);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0, title: const Text('Change Password')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text('New Password').text.bold.size(20).make(),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ).py12(),
            const Text('Re-enter Password').text.bold.size(20).make(),
            TextField(
              controller: passwordConfirmation,
              decoration: const InputDecoration(
                hintText: 'Re-enter Password',
                border: OutlineInputBorder(),
              ),
            ).py12(),
          ],
        ).px20(),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: const Text('Change Password')
              .text
              .white
              .bold
              .size(20)
              .make()
              .centered(),
        ).py12().px(20).onTap(onChangePassword),
      ),
    );
  }
}
