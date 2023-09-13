import 'package:flutter/material.dart';
import '/package.dart';

class PassengersBook extends StatefulWidget {
  static String route = '/PassengersBook';

  const PassengersBook({super.key});

  @override
  State<PassengersBook> createState() => PassengersBookState();
}

class PassengersBookState extends State<PassengersBook> {
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
              'Can passengers book instantly?'
                  .text
                  .size(35)
                  .semiBold
                  .gray800
                  .make()
                  .py32(),
              ListTile(
                onTap: () {
                  setState(() {
                    PostRide.allowInstantBooking = 1;
                    Navigator.pushNamed(context, PricePassengers.route);
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
                    PostRide.allowInstantBooking = 0;
                    Navigator.pushNamed(context, PricePassengers.route);
                  });
                },
                title: "No, I'll reply to each request myself "
                    .text
                    .size(20)
                    .gray600
                    .make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
