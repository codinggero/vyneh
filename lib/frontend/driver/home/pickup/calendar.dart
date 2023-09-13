import 'package:flutter/material.dart';
import '/package.dart';

class Calendar extends StatefulWidget {
  static String route = '/Calendar';

  const Calendar({super.key});

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title:
            'when are you going?'.text.size(25).semiBold.gray900.make().py32(),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       'when are you going?'.text.size(35).semiBold.gray900.make().py32(),
      //       Scaffold(
      //         body:
      body: PagedVerticalCalendar(
        minDate: DateTime.now().subtract(const Duration(days: 365)),
        maxDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: DateTime.now().add(const Duration(days: 3)),
        invisibleMonthsThreshold: 1,
        startWeekWithSunday: true,
        onMonthLoaded: (year, month) {},
        onDayPressed: (value) {
          setState(() {
            Schedule.date = "${value.day}-${value.month}-${value.year}";
            Navigator.pushNamed(context, GoneSchedule.route);
          });
        },
        onPaginationCompleted: (direction) {},
      ),
    );
  }
}
