import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  const MyButton2(
      {super.key,
      // ignore: non_constant_identifier_names
      required this.Title,
      required this.color,
      required this.onPressed});
  // ignore: non_constant_identifier_names
  final String Title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      // margin: EdgeInsets.symmetric(horizontal: 50),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),

      child: Center(
        child: Text(
          Title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
