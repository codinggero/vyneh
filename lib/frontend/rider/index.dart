import 'package:flutter/material.dart';
import '/package.dart';

export 'home/index.dart';
export 'navigation/index.dart';
export 'profile/index.dart';
export 'search/index.dart';

class Rider extends StatefulWidget {
  static String route = '/Rider';

  const Rider({Key? key}) : super(key: key);

  @override
  State<Rider> createState() => RiderState();
}

class RiderState extends State<Rider> {
  int selectedIndex = 0;

  static const List<Widget> pagesOptions = <Widget>[
    RiderHome(),
    NavigationScreen(),
    Search(),
    Profile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesOptions.elementAt(selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        itemShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        currentIndex: selectedIndex,
        onTap: onItemTapped,
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
