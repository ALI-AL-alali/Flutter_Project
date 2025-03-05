import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  MyButton2({super.key, required this.Title, required this.color, required this.onPressed});
  final String Title;
  final Color color;
  final VoidCallback  onPressed;
  
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
