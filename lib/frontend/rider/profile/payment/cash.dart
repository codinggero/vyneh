import 'package:flutter/material.dart';
import '/package.dart';

class Cash extends StatefulWidget {
  static String route = '/Cash';

  const Cash({super.key});

  @override
  State<Cash> createState() => CashState();
}

class CashState extends State<Cash> {
  dynamic bookingId;
  dynamic totalMount;
  @override
  void initState() {
    super.initState();
  }

  void onPressed() {
    api.request.cashPayment(
      bookingId: bookingId,
      totalMount: totalMount,
      onIndicator: (response) {
        Indicator.call(response, context: context);
      },
      onSuccess: (response) {
        Indicator.call(response, context: response.message);
      },
      onError: (err) {
        if (err.runtimeType == Res) {
          Snackbar.error(context, message: err.message);
        } else {
          Snackbar.error(context, message: err);
        }
      },
    );
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
                  Assets.drawable.dollar,
                  width: 130,
                ).pOnly(top: 50),
                const Text('Pay on Cash')
                    .text
                    .size(23)
                    .make()
                    .pOnly(bottom: 25, top: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Booking Id',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      bookingId = value;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Total Amount',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      totalMount = value;
                    });
                  },
                ).py12(),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Vx.blue500),
                  child: const Text('Pay')
                      .text
                      .white
                      .size(20)
                      .bold
                      .make()
                      .centered(),
                ).py16().onTap(onPressed),
              ],
            ).px12(),
          ),
        ),
      ),
    );
  }
}
