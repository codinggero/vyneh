import 'package:flutter/material.dart';
import '/package.dart';

export 'update.dart';

class ForgotPassword extends StatefulWidget {
  static String route = '/ForgotPassword';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  void onSendOTP() {
    api.request.resendOtp(
      email: email.text,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Snackbar.information(context, message: "OTP code send on your email.");
        Navigator.pushNamed(context, Otp.route, arguments: {
          'route': ForgotPassword.route,
          'email': email.text,
          'response': response.data
        });
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
        backgroundColor: const Color(0xFFF5F3F3),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Center(
                  child: Lottie.asset(
                    Assets.animations.password,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: email,
                hintText: 'Enter Email',
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: BtnWidget(
                  title: 'Send OTP',
                  btnTxtClr: Colors.white,
                  btnBgClr: Colors.black,
                  onTap: onSendOTP,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Signin.route);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
