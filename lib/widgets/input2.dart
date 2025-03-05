import 'package:flutter/material.dart';

class input2 extends StatelessWidget {
  const input2({
    super.key,
    required this.title,
    required this.controller,
    this.obscureText = false,
    required this.validator,
  });
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
            hintText: title,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
