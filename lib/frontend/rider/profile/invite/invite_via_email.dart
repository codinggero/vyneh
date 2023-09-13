import 'package:flutter/material.dart';
import '/package.dart';

class InviteViaEmail extends StatelessWidget {
  static String route = '/InviteViaEmail';

  const InviteViaEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Invite Friend",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Share the word and earn\nexisting benefits."
              .text
              .align(TextAlign.center)
              .size(22)
              .align(TextAlign.center)
              .lineHeight(1.5)
              .make()
              .centered()
              .pOnly(top: 20, bottom: 30),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Lottie.asset(
              Assets.animations.email,
              fit: BoxFit.fitHeight,
            ),
          ),
          "Friend's Name".text.size(16).bold.make().pOnly(bottom: 8),
          TextField(
            decoration: InputDecoration(
                hintText: "Enter Name",
                fillColor: Colors.grey[100],
                filled: true,
                suffixIcon: const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ).pOnly(bottom: 20),
          "Email".text.size(16).bold.make().pOnly(bottom: 8),
          TextField(
            decoration: InputDecoration(
                hintText: "Enter Email",
                fillColor: Colors.grey[100],
                filled: true,
                suffixIcon: const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ).pOnly(bottom: 20),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              "  Success !".text.size(16).color(Colors.green).make()
            ],
          ).pOnly(bottom: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(0),
            ),
            child: Ink(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Invite",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ).pSymmetric(h: 30),
    );
  }
}
