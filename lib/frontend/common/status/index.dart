import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/package.dart';

class Status extends StatefulWidget {
  static String route = '/Status';

  const Status({super.key});

  @override
  State<Status> createState() => StatusState();
}

class StatusState extends State<Status> {
  dynamic arguments;
  dynamic message = 'Oups! Something went wrong!';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      arguments = ModalRoute.of(context)!.settings.arguments ?? {};
      message = arguments['message'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: hexColor("#E9EBF7"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.drawable.error),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kDebugMode ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),),
    );
  }
}
