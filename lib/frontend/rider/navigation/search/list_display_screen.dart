import 'package:flutter/material.dart';
import '/package.dart';

class ListDisplay extends StatefulWidget {
  static String route = '/ListDisplay';

  const ListDisplay({super.key});

  @override
  State<ListDisplay> createState() => ListDisplayState();
}

class ListDisplayState extends State<ListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Fri 17 March').text.size(30).bold.make().px(20).py(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListTile(
                  leading: Column(children: [
                    const Text('22:50').text.size(18).black.bold.make(),
                    const Text('1h30').text.size(15).black.bold.make()
                  ]),
                  title: 'Vienna Main train station '
                      .text
                      .size(20)
                      .bold
                      .black
                      .make(),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black,
                      ).py(20),
                      const Text('2.5 km from your departure')
                          .text
                          .color(Colors.black)
                          .size(14)
                          .make()
                    ],
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  leading: Column(children: [
                    const Text('04:34').text.size(18).black.bold.make(),
                    const Text('+1').text.size(14).black.bold.make()
                  ]),
                  title: 'Bratislava Mlynske Nivy Bus'
                      .text
                      .size(20)
                      .bold
                      .make()
                      .pOnly(bottom: 20),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black,
                      ),
                      'change of vehicle'
                          .text
                          .size(14)
                          .color(Colors.black)
                          .make()
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Column(children: [
                    const Text('02:15').text.size(18).black.bold.make(),
                    const Text('2h30').text.size(15).black.bold.make()
                  ]),
                  title: 'Vienna Main train station '
                      .text
                      .size(20)
                      .bold
                      .black
                      .make()
                      .pOnly(bottom: 20, top: 10),
                  subtitle: const Text('Bratislava')
                      .text
                      .color(Colors.black)
                      .size(14)
                      .make(),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: Column(children: [
                    const Text('04:34').text.size(18).black.bold.make(),
                    const Text('+1').text.size(14).black.bold.make()
                  ]),
                  title: 'Bratislava Mlynske Nivy Bus'
                      .text
                      .size(20)
                      .black
                      .bold
                      .make(),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black,
                      ),
                      const Text('2.5 km from your departure')
                          .text
                          .color(Colors.black)
                          .size(14)
                          .make()
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price for 2 \npassengers')
                    .text
                    .size(20)
                    .black
                    .make()
                    .pOnly(bottom: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Standard').text.size(20).black.make(),
                    const Text('\$38.08').text.size(30).black.make()
                  ],
                )
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          Divider(
            thickness: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 25,
            ),
            title: 'Share ride'.text.color(Colors.black).size(20).bold.make(),
          ).py16(),
          FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      )),
    );
  }
}
