import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  const BtnWidget({
    required this.title,
    required this.btnTxtClr,
    required this.btnBgClr,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final Color btnTxtClr;
  final Color btnBgClr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: btnBgClr,
          foregroundColor: btnTxtClr,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
