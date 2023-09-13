import 'package:flutter/material.dart';
import '/package.dart';

class Permissions extends StatefulWidget {
  static String route = '/Permissions';
  const Permissions({Key? key}) : super(key: key);

  @override
  State<Permissions> createState() => PermissionsState();
}

class PermissionsState extends State<Permissions> {
  Api api = Api.instance;
  List permission = [
    {
      'index': 0,
      'label': 'Location',
      'icon': Assets.drawable.location,
      'permission': Permission.location,
      'status': PermissionStatus.denied
    },
    {
      'index': 1,
      'label': 'Contacts',
      'icon': Assets.drawable.contacts,
      'permission': Permission.contacts,
      'status': PermissionStatus.denied
    },
    {
      'index': 2,
      'label': 'Storage',
      'icon': Assets.drawable.storage,
      'permission': Permission.storage,
      'status': PermissionStatus.denied
    },
    {
      'index': 3,
      'label': 'Camera',
      'icon': Assets.drawable.camera,
      'permission': Permission.camera,
      'status': PermissionStatus.denied
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkPermission();
    });
  }

  static Color hexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  checkPermission() {
    List<int> ok = [];
    for (var i = 0; i < permission.length; i++) {
      if (permission[i]['status'] != PermissionStatus.granted) {
        ok.add(i);
      }
    }

    return ok.length;
  }

  Widget future({
    required int index,
    required String label,
    required String icon,
    required Permission perm,
    required PermissionStatus status,
    required void Function(dynamic) callback,
    required void Function(bool)? onChangedPermission,
  }) {
    return FutureBuilder<dynamic>(
      future: api.permissions.status(perm), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          permission[index]['status'] = data;
          callback(data);
          return ListTile(
            tileColor: Colors.white,
            title: Text(label),
            leading: SizedBox(height: 60, width: 100, child: Img(src: icon)),
            subtitle: Text(
              data == PermissionStatus.granted ? 'Granted' : 'Not Granted',
            ),
            trailing: Switch(
              value: data == PermissionStatus.granted ? true : false,
              onChanged: onChangedPermission,
              activeColor: Colors.green,
            ),
          );
        } else {
          return ListTile(
            tileColor: Colors.white,
            title: Text(label),
            leading: SizedBox(height: 60, width: 100, child: Img(src: icon)),
            subtitle: const Text('Not Granted'),
            trailing: Switch(
              value: false,
              onChanged: onChangedPermission,
              activeColor: Colors.orange,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: hexColor('#FEFCFD'),
        appBar: Appbar.appbar(
          context,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 75),
            Img(src: Assets.drawable.gps),
            SizedBox(height: MediaQuery.of(context).size.height / 75),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'BlaBlaCar and ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'its partners ',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text:
                          "use cookies (or similar technology) to measure and analyze how our platform is used, and to show ads based on your interests. By clicking 'Accept and Continue', you agree to the above. You can change your preference at any time in the cookies setting. Note that blocking some types of cookies may impact your experience using BlaBlaCar and certain features we offer.\nFor more info, please check our ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    TextSpan(
                      text: 'Cookies Policy',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 75),
            Expanded(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var p in permission)
                    future(
                      index: p['index'],
                      label: p['label'],
                      icon: p['icon'],
                      perm: p['permission'],
                      status: p['status'],
                      callback: (data) {
                        int ok = checkPermission();
                        if (ok == 0) {
                          Future.delayed(Duration.zero, () {
                            Navigator.popAndPushNamed(context, Splash.route);
                          });
                        }
                      },
                      onChangedPermission: (value) {
                        api.permissions.request(p['permission']).then((value) {
                          setState(() {
                            p['status'] = value;
                          });
                        });
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
