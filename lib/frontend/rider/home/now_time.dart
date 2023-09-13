import 'package:flutter/material.dart';
import '/package.dart';

class NowTime extends StatefulWidget {
  static String route = '/NowTime';

  const NowTime({super.key});

  @override
  State<NowTime> createState() => _NowTimeState();
}

class _NowTimeState extends State<NowTime> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 12, minute: 00);
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 40,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              'When do you want to Picked up?'
                  .text
                  .size(45)
                  .semiBold
                  .gray800
                  .make()
                  .py32(),
              // Date Picker
              InkWell(
                onTap: () {
                  Pickers.date(context).then((date) {
                    if (date != null) {
                      Schedule.date = '${date.day}-${date.month}-${date.year}';
                      dateTime = date;
                      setState(() {});
                    }
                  });
                },
                child: Text(
                    "${dateTime.day}-${dateTime.month}-${dateTime.year}",
                    style: const TextStyle(fontSize: 25)),
              ).py16(),

              const Divider(
                color: Colors.grey,
              ),

              InkWell(
                onTap: () async {
                  Pickers.time(context).then((time) {
                    if (time != null) {
                      Schedule.time = time.format(context);
                      timeOfDay = time;
                      setState(() {});
                    }
                  });
                },
                child: Text(
                  timeOfDay.format(context),
                  style: const TextStyle(fontSize: 25),
                ),
              ).pOnly(bottom: 25, top: 12),

              ListTile(
                leading: const Icon(
                  Icons.badge,
                  color: Colors.black,
                ),
                title: 'Choose your exact pickup time up to 30 days in advance'
                    .text
                    .size(18)
                    .make(),
              ),
              const Divider(thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.label,
                  color: Colors.black,
                ),
                title: 'Extra wait time include to meet your ride'
                    .text
                    .size(18)
                    .make(),
              ),
              const Divider(thickness: 2),
              ListTile(
                leading: const Icon(
                  Icons.browse_gallery,
                  color: Colors.black,
                ),
                title: 'Cancel at no charge up to 60 days in advance'
                    .text
                    .size(18)
                    .make(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: 'See terms'.text.underline.size(18).bold.make(),
              ).pOnly(bottom: 50, top: 30),
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: 'Set picked time'.text.size(20).white.make().centered(),
              ).onTap(
                () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
