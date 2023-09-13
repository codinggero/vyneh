import 'package:flutter/material.dart';
import '/package.dart';

class ApplePay extends StatefulWidget {
  static String route = '/ApplePay';

  const ApplePay({super.key});

  @override
  State<ApplePay> createState() => ApplePayState();
}

class ApplePayState extends State<ApplePay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.drawable.paypal1,
                  width: 130,
                ).pOnly(top: 50),
                const Text('Pay with PayPal')
                    .text
                    .size(23)
                    .make()
                    .pOnly(bottom: 25, top: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ).py12(),
                Row(
                  children: [
                    Checkbox(
                        value: false,
                        onChanged: (val) {
                          setState(() {
                            val = val;
                          });
                        }),
                    const Text('Stay logged in for faster checkout')
                        .text
                        .size(15)
                        .semiBold
                        .make()
                        .px(5),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Vx.blue400)),
                        child: const Icon(
                          Icons.question_mark_outlined,
                          size: 15,
                          color: Vx.blue400,
                        ).p(3))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Not recommended on shared devices.')
                      .text
                      .size(13)
                      .make()
                      .pOnly(left: 50),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Vx.blue500),
                  child: const Text('Log In')
                      .text
                      .white
                      .size(20)
                      .bold
                      .make()
                      .centered(),
                ).py16(),
                const Text('Having trouble logging in ?')
                    .text
                    .size(20)
                    .blue500
                    .make(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Divider(),
                    const Text('or').text.gray300.make().px(5),
                    const Divider(),
                  ],
                ).py12(),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Vx.gray200),
                  child: const Text('Pay with Debit or Credit Card')
                      .text
                      .size(18)
                      .bold
                      .make()
                      .centered(),
                ).py16(),
              ],
            ).px12(),
          ),
        ),
      ),
    );
  }
}
