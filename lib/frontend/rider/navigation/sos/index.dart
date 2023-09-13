import 'package:flutter/material.dart';

class Sos extends StatefulWidget {
  static String route = '/Sos';

  const Sos({super.key});

  @override
  State<Sos> createState() => SosState();
}

class SosState extends State<Sos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: const Text('SOS')),
      ),
    );
  }
}
