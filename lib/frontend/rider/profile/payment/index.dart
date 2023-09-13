import 'package:flutter/material.dart';
import '/package.dart';

export 'crdit_debit.dart';
export 'cash.dart';
export 'apple_pay.dart';

class Payment extends StatelessWidget {
  static String route = '/Payment';

  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Add Payments')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Add payment".text.size(26).bold.make().pOnly(bottom: 10, top: 20),
          Tiles(
            text: const Text("Credit or Debit Card"),
            color: Colors.white,
            icon: Image.asset(Assets.drawable.credit),
            tap: () {
              Navigator.pushNamed(context, CreditDebit.route);
            },
          ),
          Tiles(
            text: const Text("Google Pay"),
            color: Colors.white,
            icon: Image.asset(Assets.drawable.googlepay),
            tap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                text:
                    'Stay tuned. We are launching soon. We are working hard. We are almost ready to launch. Something awesome is coming soon. Be first to know.',
              );
              //Navigator.pushNamed(context, GooglePay.route);
            },
          ),
          Tiles(
            text: const Text("Paypal"),
            color: Colors.white,
            icon: Image.asset(Assets.drawable.paypal),
            tap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                text:
                    'Stay tuned. We are launching soon. We are working hard. We are almost ready to launch. Something awesome is coming soon. Be first to know.',
              );

              //Navigator.pushNamed(context, Paypal.route);
            },
          ),
          Tiles(
            text: const Text("Apple Pay"),
            color: Colors.white,
            icon: Image.asset(Assets.drawable.apple),
            tap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                text:
                    'Stay tuned. We are launching soon. We are working hard. We are almost ready to launch. Something awesome is coming soon. Be first to know.',
              );
              // Navigator.pushNamed(context, ApplePay.route);
            },
          ),
          Tiles(
            text: const Text("Cash"),
            color: Colors.white,
            icon: Image.asset(Assets.drawable.cash),
            tap: () {
              Navigator.pushNamed(context, Cash.route);
            },
          ),
        ],
      ).pSymmetric(h: 15),
    );
  }
}
