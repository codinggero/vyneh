import 'package:flutter/material.dart';

import '/package.dart';

class Notifications extends StatefulWidget {
  static String route = '/Notifications';

  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List notification = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationList();
      setState(() {});
    });
  }

  void notificationList() {
    api.request.notificationList(
      onIndicator: (response) {
        // Indicator.call(response, context: context);
      },
      onCache: (response) {
        setState(() {
          notification = response ?? [];
        });
      },
      onSuccess: (response) {
        setState(() {
          notification = response.data['notificationList'];
        });
      },
      onError: (err) {
        // Snackbar.error(context, message: err);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: notification.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
              title: Text("${notification[index]['heading']}"),
              subtitle: Text('${notification[index]['message']}'),
            ),
          );
        },
      ),
    );
  }
}
