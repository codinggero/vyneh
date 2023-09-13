import 'package:flutter/material.dart';
import '/package.dart';

class Sure extends StatefulWidget {
  static String route = '/Sure';

  const Sure({super.key});

  @override
  State<Sure> createState() => SureState();
}

class SureState extends State<Sure> {
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
          ),
        ),
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
              'Think comfort, keep the middle seat empty!'
                  .text
                  .size(35)
                  .semiBold
                  .gray800
                  .make()
                  .py32(),
              ListTile(
                onTap: () {
                  setState(() {
                    PostRide.isMiddleSeatEmpty = 1;
                    Navigator.pushNamed(context, Passengers.route);
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
                    PostRide.isMiddleSeatEmpty = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Passengers(),
                      ),
                    );
                  });
                },
                title: "No, I'll squeeze in 3 ".text.size(22).gray600.make(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
