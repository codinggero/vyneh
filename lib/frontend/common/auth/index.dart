import 'package:flutter/material.dart';
import '/package.dart';

class Auth extends StatefulWidget {
  static String route = '/Auth';
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (api.user.id == null) AlertBox().showMyDialog(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const double logoSize = 150.0;
    const double animationSize = 300.0;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Lottie.asset(
                  Assets.animations.onboarding,
                  height: animationSize,
                  width: animationSize,
                ),
              ),
              const Text(
                'Welcome to Vyneh',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black87,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: BtnWidget(
                      title: 'Login',
                      btnTxtClr: Colors.white,
                      btnBgClr: Colors.black,
                      onTap: () {
                        Navigator.pushNamed(context, Signin.route);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: BtnWidget(
                      title: 'Register',
                      btnTxtClr: Colors.white,
                      btnBgClr: Colors.black,
                      onTap: () {
                        Navigator.pushNamed(context, Signup.route);
                      },
                    ),
                  ),
                  Image.asset(
                    Assets.drawable.logo,
                    width: logoSize,
                    colorBlendMode: BlendMode.dstATop,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
