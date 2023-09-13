import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Kaar',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 40,
          ),
        )
      ],
    );
  }
}
