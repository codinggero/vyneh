import 'package:flutter/material.dart';
import '/package.dart';

class InviteViaMobile extends StatelessWidget {
  static String route = '/InviteViaMobile';

  const InviteViaMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Invite Friend"),
        centerTitle: true,
        elevation: 0,
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
            child: Lottie.asset(Assets.animations.phone, fit: BoxFit.fitHeight),
          ).pOnly(bottom: 30),
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
          "Mobile Number".text.size(16).bold.make().pOnly(bottom: 8),
          IntlPhoneField(
            countries: Cities.countries,
            initialCountryCode: 'US',
            dropdownIconPosition: IconPosition.leading,
            flagsButtonMargin: const EdgeInsets.only(left: 10),
            showCountryFlag: false,
            onCountryChanged: (country) {},
            pickerDialogStyle: PickerDialogStyle(
              mainAxisSize: MainAxisSize.min,
            ),
            dropdownTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                hintText: "Mobile Number",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
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
