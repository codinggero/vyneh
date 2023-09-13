import 'package:flutter/material.dart';
import '/package.dart';

class Signin extends StatefulWidget {
  static String route = '/Signin';

  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => SigninState();
}

class SigninState extends State<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureText = true;

  void onSignin() {
    api.request.login(
      email: email.text,
      password: password.text,
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
        backgroundColor: const Color(0xFFF5F3F3),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: Lottie.asset(
                  Assets.animations.hello,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              CustomTextFieldWidget(
                controller: email,
                hintText: 'Email',
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
                obscureText: false,
              ),
              CustomTextFieldWidget(
                controller: password,
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (obscureText) {
                        obscureText = false;
                      } else {
                        obscureText = true;
                      }
                    });
                  },
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                obscureText: obscureText,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              BtnWidget(
                title: 'Login',
                btnTxtClr: Colors.white,
                btnBgClr: Colors.black,
                onTap: onSignin,
              ),
              const SizedBox(height: 28.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPassword.route);
                },
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPassword.route);
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Signup.route);
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DriverRegistration.route);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                ),
                child: const Text(
                  'Become a Driver',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Poppins',
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
