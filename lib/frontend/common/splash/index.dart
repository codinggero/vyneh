import 'package:flutter/material.dart';
import '/package.dart';

class Splash extends StatefulWidget {
  static String route = '/';

  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      init();
    });
  }

  Future<void> init() async {
    api.init().then((value) {
      dynamic email = api.user.email;
      dynamic password = api.user.password;
      dynamic currentUser = api.user.currentUser;
      dynamic id = api.user.id;
      dynamic token = api.user.token;

      Config.token = token;

      if (email == null || password == null) {
        Navigator.popAndPushNamed(context, Onboarding.route);
      } else if (currentUser == null) {
        Navigator.popAndPushNamed(context, Become.route);
      } else {
        api.permissions.multiPermissionStatus([
          Permission.location,
          Permission.contacts,
          Permission.camera,
          Permission.storage,
        ]).then((status) {
          if (status) {
            api.permissions.multiServiceStatus([
              Permission.location,
            ]).then((enabled) {
              if (enabled) {
                api.request
                    .getUser(
                  userId: id,
                  onIndicator: (bb) {},
                  onError: (err) {},
                  onSuccess: (res) {},
                )
                    .then((value) {
                  if (currentUser == 'Rider') {
                    Navigator.popAndPushNamed(context, Rider.route);
                  } else if (currentUser == 'Driver') {
                    Navigator.popAndPushNamed(context, Driver.route);
                  }
                });
              } else {
                Navigator.pushNamed(
                  context,
                  Status.route,
                  arguments: {"message": "$enabled"},
                );
              }
            }, onError: (err) {
              Navigator.pushNamed(
                context,
                Status.route,
                arguments: {"message": "$err"},
              );
            });
          }
        }, onError: (err) {
          Navigator.pushNamed(context, Permissions.route);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                Assets.drawable.logo,
                colorBlendMode: BlendMode.dstATop,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
