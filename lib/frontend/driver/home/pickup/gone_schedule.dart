import 'package:flutter/material.dart';
import '/package.dart';

class GoneSchedule extends StatefulWidget {
  static String route = '/GoneSchedule';

  const GoneSchedule({super.key});

  @override
  State<GoneSchedule> createState() => GoneScheduleState();
}

class GoneScheduleState extends State<GoneSchedule> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 12, minute: 00);

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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'At what time will you pick passengers up?'
                .text
                .size(38)
                .semiBold
                .gray900
                .make()
                .py32(),
            InkWell(
              onTap: () {
                Pickers.time(context).then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        timeOfDay = value;
                        Schedule.time = value.format(context);
                      });
                    }
                  },
                );
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Vx.gray400),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    timeOfDay
                        .format(context)
                        .text
                        .size(45)
                        .bold
                        .gray800
                        .make()
                        .px(35),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      size: 40,
                      color: Colors.blue,
                    )
                  ],
                ),
              ).px(25),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, Sure.route);
          });
        },
        child: const Icon(
          Icons.arrow_forward,
          size: 20,
        ),
      ).p(15),
    );
  }
}
