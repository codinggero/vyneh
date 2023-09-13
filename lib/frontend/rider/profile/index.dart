import 'package:flutter/material.dart';
import '/package.dart';

export 'update/index.dart';
export 'invite/index.dart';
export 'password/index.dart';
export 'payment/index.dart';
export 'setting/index.dart';

// ignore: camel_case_types
class Profile extends StatefulWidget {
  static String route = '/Profile';

  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  void logout() async {
    api.request.logout(
      onIndicator: (res) {
        Indicator.call(res, context: context);
      },
      onSuccess: (response) {
        Navigator.popAndPushNamed(context, Signin.route);
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    color: Vx.black, shape: BoxShape.circle),
              ).py16(),
              Text('${api.user.firstName} ${api.user.lastName}')
                  .text
                  .size(25)
                  .bold
                  .make(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Vx.white,
                ),
                child: const Text('Edit Profile').text.bold.black.make(),
              ).onTap(() {
                Navigator.pushNamed(context, ProfileUpdate.route);
              }),

              // Container(
              //   height: 80,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20), color: Vx.black),
              //   child: ListTile(
              //     //  title: const Text('').text.size(18).white.make(),
              //     title: Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(40),
              //         color: Vx.white,
              //       ),
              //       child: const Text('Edit Profile').text.bold.black.make(),
              //     ).onTap(() {
              //       Navigator.pushNamed(context, ProfileUpdate.route);
              //     }),
              //   ).centered(),
              // ),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text('Account setting')
                    .text
                    .gray400
                    .bold
                    .size(18)
                    .make(),
              ).py16(),
              Container(
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Vx.gray100,
                          blurRadius: 3.0,
                          spreadRadius: 4.0,
                          offset: Offset.zero)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    list(
                        'Account Information',
                        'Change your account information',
                        Icons.person_outline,
                        () {}),
                    const Divider().px8(),
                    list('Payments Methods', 'Add your credit or debit card',
                        Icons.credit_card, () {
                      Navigator.pushNamed(context, Payment.route);
                    }),
                    const Divider().px8(),
                    list('Change Password', 'Change your password',
                        Icons.lock_outlined, () {
                      Navigator.pushNamed(context, PasswordUpdate.route);
                    }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text('Other').text.gray400.bold.size(18).make(),
              ).py16(),
              Container(
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Vx.gray100,
                          blurRadius: 3.0,
                          spreadRadius: 4.0,
                          offset: Offset.zero)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    list('My Vyneh', 'See your record', Icons.history_outlined,
                        () {
                      Navigator.pushNamed(context, Search.route);
                    }),
                    const Divider().px8(),
                    list('Contact Support', 'any problem you can contact',
                        Icons.contact_support_outlined, () {}),
                    const Divider().px8(),
                    list('Share App', 'Share this app to your friends',
                        Icons.share_outlined, () {
                      Share.share('check out my website https://example.com');
                    }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                    const Text('About Page').text.gray400.bold.size(18).make(),
              ).py16(),
              Container(
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Vx.gray100,
                          blurRadius: 3.0,
                          spreadRadius: 4.0,
                          offset: Offset.zero)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    list('Invite your friends', null, Icons.person_add_alt, () {
                      Navigator.pushNamed(context, Invite.route);
                    }),
                    const Divider().px8(),
                    list('My Coins', 'your coins', Icons.circle_rounded, () {}),
                    const Divider().px8(),
                    list('My Rewards', 'your Rewards',
                        Icons.card_giftcard_outlined, () {}),
                    const Divider().px8(),
                    list('My Setting', 'set all the setting', Icons.settings,
                        () {
                      Navigator.pushNamed(context, Setting.route);
                    }),
                    const Divider().px8(),
                    list('Logout', 'Logout your Account', Icons.logout_outlined,
                        () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            title: const Text("Log Out"),
                            content:
                                const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: const Text("Logout"),
                                onPressed: () {
                                  logout();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ).px16(),
        ),
      ),
    );
  }

  ListTile list(String title, String? subtitle, var leading, var tap) {
    return ListTile(
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
      subtitle: subtitle != null ? Text(subtitle).text.make() : null,
    );
  }
}
