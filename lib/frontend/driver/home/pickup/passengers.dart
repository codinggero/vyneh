import 'package:flutter/material.dart';
import '/package.dart';

class Passengers extends StatefulWidget {
  static String route = '/Passengers';

  const Passengers({super.key});

  @override
  State<Passengers> createState() => PassengersState();
}

class PassengersState extends State<Passengers> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'So how many\nVyneh Passengers  can you take'
                  .text
                  .size(40)
                  .gray900
                  .bold
                  .make()
                  .py24(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (count == 0) {
                          count;
                        } else if (count >= 0) {
                          count--;
                        }
                      });
                    },
                    icon: Image.asset(
                      Assets.drawable.minimize,
                      color: Colors.blue,
                      height: 100,
                    ),
                  ).px(60),
                  '$count'.text.size(70).gray900.bold.make(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    },
                    color: Colors.blue,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 35,
                    ),
                  ).px(60)
                ],
              ).py24()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            PostRide.totalSeats = count;
            Navigator.pushNamed(context, PassengersBook.route);
          });
        },
        child: const Icon(Icons.arrow_forward),
      ).px12(),
    );
  }
}
