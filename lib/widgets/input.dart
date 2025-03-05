import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(
      {required this.text,
      required this.validator,
      required this.mycontroller,
      this.keyboardType = TextInputType.text});

  final String text;
  final String? Function(String?) validator;
  final TextEditingController mycontroller;
  final TextInputType keyboardType;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      keyboardType: keyboardType,
      validator: validator,
      textAlign: TextAlign.center,
      onChanged: (value) => {},
      decoration: InputDecoration(
        hintText: text,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
