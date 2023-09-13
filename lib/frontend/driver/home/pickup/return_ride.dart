import 'package:flutter/material.dart';
import '/package.dart';

class ReturnRide extends StatefulWidget {
  static String route = '/ReturnRide';

  const ReturnRide({super.key});

  @override
  State<ReturnRide> createState() => ReturnRideState();
}

class ReturnRideState extends State<ReturnRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                Assets.drawable.social,
                width: double.infinity,
                height: 250,
              ).py32(),
              'Coming back as well?\nPublish your return ride now!'
                  .text
                  .size(35)
                  .semiBold
                  .gray800
                  .make()
                  .py32(),
              ListTile(
                onTap: () {
                  setState(() {
                    PostRide.isReturnTrip = '1';
                    Navigator.pushNamed(context, Routes.route);
                  });
                },
                title: 'Yes sure!'
                    .text
                    .size(25)
                    .color(Theme.of(context).colorScheme.secondary)
                    .make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(thickness: 2).py12(),
              ListTile(
                onTap: () {
                  setState(() {
                    PostRide.isReturnTrip = '0';
                    Navigator.pushNamed(context, PhoneVerify.route);
                  });
                },
                title: "No, thanks ".text.size(22).gray600.make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
