import 'package:flutter/material.dart';
import '/package.dart';

class Search extends StatefulWidget {
  static String route = '/Search';

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  bool check = false;
  int? groupValue;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'My Vyneh',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 5,
          bottom: const TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Ride',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Tab(
                child: Text('Package'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Screen
            // Started
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ListDisplay.route);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Column(
                              children: [
                                const Text('22:50').text.size(18).bold.make(),
                                const Text('7hl5').text.size(15).bold.make(),
                              ],
                            ),
                            title: const Text('Vienna',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            subtitle: const Row(
                              children: [
                                Icon(Icons.person_2_outlined),
                                Icon(Icons.person_2_outlined),
                                Icon(Icons.person_2_outlined),
                              ],
                            ),
                            trailing:
                                const Text('\$36.67').text.bold.size(20).make(),
                          ),
                          ListTile(
                            leading: Column(
                              children: [
                                const Text('04:34').text.size(18).bold.make(),
                                const Text('+1').text.size(14).bold.make(),
                              ],
                            ),
                            title: const Text('Budapest',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            subtitle: const Row(
                              children: [
                                Icon(Icons.person_2_outlined),
                                Icon(Icons.person_2_outlined),
                                Icon(Icons.person_2_outlined),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: const Text('Regiolet',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            subtitle: const Text('1 change')
                                .text
                                .size(14)
                                .bold
                                .make(),
                            trailing: const Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // End All Screen

            // Car Screen
            // Screen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Today',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold))
                      .py(20),
                  const Text('No Car rides for this day',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40))
                      .centered(),
                  Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: const Text('Create a ride alert',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold))
                        .centered(),
                  ).centered().py(50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
