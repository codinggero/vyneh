import 'package:flutter/material.dart';
import '/package.dart';

class Otp extends StatefulWidget {
  static String route = '/Otp';
  const Otp({super.key});

  @override
  State<Otp> createState() => OtpState();
}

class OtpState extends State<Otp> {
  dynamic arguments;
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments ?? {};
      setState(() {});
    });
  }

  void onContinue() {
    var route = arguments['route'];
    if (route == ForgotPassword.route) {
      var email = arguments['email'];
      api.request.confirmOtp(
        email: email,
        otp: otp.text,
        onIndicator: (response) {
          Indicator.call(response, context: context);
        },
        onSuccess: (response) {
          Navigator.pushNamed(
            context,
            ChangePassword.route,
            arguments: {
              'email': email,
              'otp': otp.text,
            },
          );
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

    if (route == Signup.route) {
      var email = arguments['email'];
      api.request.confirmOtp(
        email: email,
        otp: otp.text,
        onIndicator: (response) {
          Indicator.call(response, context: context);
        },
        onSuccess: (response) {
          Navigator.pushNamed(context, Become.route);
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
  }

  void onResend() {
    var email = arguments['email'];
    api.request.resendOtp(
      email: email,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Snackbar.information(context, message: "OTP code send on your email.");
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Verification",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ).onTap(() {
            Navigator.pop(context);
          }),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 1 / 2.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(blurRadius: 0.3)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        child: Text(
                          "Enter the verification code sent via",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        controller: otp,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ).pOnly(bottom: 20),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        child: "Continue"
                            .text
                            .color(Colors.white)
                            .make()
                            .centered(),
                      ).pSymmetric(h: 20, v: 20).onTap(onContinue),
                      "Request a new verification code"
                          .text
                          .color(Colors.grey)
                          .make()
                          .centered()
                    ],
                  ).pSymmetric(h: 10),
                ),
                const Text(
                  "Resend Verification Code ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ).onTap(onResend),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
