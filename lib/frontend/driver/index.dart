import 'package:flutter/material.dart';
import '/package.dart';

export './home/index.dart';

class Driver extends StatefulWidget {
  static String route = '/Driver';

  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => DriverState();
}

class DriverState extends State<Driver> {
  int _selectedIndex = 0;

  static const List<Widget> _pagesOptions = <Widget>[
    DriverHome(),
    NavigationScreen(),
    Search(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        itemShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.car_crash),
            title: const Text('My Vyneh'),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
