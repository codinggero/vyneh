import 'package:flutter/material.dart';
import '/package.dart';

Row qty({
  dynamic quantity,
  void Function(String)? onChanged,
  bool readOnly = true,
}) {
  return Row(
    children: [
      const Text(
        'Qty: ',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
            readOnly: readOnly,
            decoration: const InputDecoration(
              hintText: '0',
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

Row radio({
  required String title,
  dynamic value,
  dynamic groupValue,
  void Function(dynamic)? onChanged,
}) {
  return Row(
    children: [
      Text(title).text.size(18).bold.make(),
      Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      )
    ],
  );
}

CarouselSlider carousel(context, {List items = const []}) {
  return CarouselSlider(
    options: CarouselOptions(
      height: MediaQuery.of(context).size.width * 0.5,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      onPageChanged: (i, c) {},
      scrollDirection: Axis.horizontal,
    ),
    items: items.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            width: 330,
            child: Image.asset(
              i,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      );
    }).toList(),
  );
}

Column category(String title, String img, var tap, {double fontSize = 18}) {
  return Column(
    children: [
      InkWell(
        onTap: tap,
        child: Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // color: Colors.grey[300]
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.centerLeft,
                colors: [Colors.blue, Vx.green800, Vx.blue700]),
          ),
          child: Image.asset(
            img,
            cacheHeight: 45,
          ),
        ).pOnly(bottom: 10),
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
