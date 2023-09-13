import 'package:flutter/material.dart';
import '/package.dart';

class Pickups extends StatelessWidget {
  static String route = '/Pickups';

  const Pickups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(onPressed: (){
        // }, icon: const Icon(Icons.close, color: Colors.blue, size: 30,),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Pick-Up".text.size(30).bold.make(),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onTap: () {
                Navigator.pushNamed(context, PickupLocation.route);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE4E9E4),
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 26,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)),
            )
          ],
        ),
      ),
    );
  }
}
