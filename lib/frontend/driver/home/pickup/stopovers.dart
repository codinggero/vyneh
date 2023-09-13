import 'package:flutter/material.dart';
import '/package.dart';

class Stopovers extends StatefulWidget {
  static String route = '/Stopovers';

  const Stopovers({super.key});

  @override
  State<Stopovers> createState() => StopoversState();
}

class StopoversState extends State<Stopovers> {
  dynamic legs = PostRide.route['legs'];
  dynamic steps = PostRide.route['legs'][0]['steps'];

  @override
  void initState() {
    super.initState();
  }

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
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Add stopovers to get more passengers'
                  .text
                  .size(30)
                  .semiBold
                  .gray900
                  .make()
                  .py(40),
              TextButton(
                  onPressed: () {}, child: 'add city'.text.size(18).make())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            PostRide.stops = steps;
            Navigator.pushNamed(context, Calendar.route);
          });
        },
        child: const Icon(Icons.arrow_forward),
      ).p(15),
    );
  }
}
