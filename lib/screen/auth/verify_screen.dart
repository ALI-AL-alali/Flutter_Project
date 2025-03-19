// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter/material.dart';

// class VerifyScreen extends StatelessWidget {
//   const VerifyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: OtpTextField(
//           numberOfFields: 5,
//           borderColor: const Color.fromARGB(255, 2, 2, 175),
//           //set to true to show as box or false to show as dash
//           showFieldAsBox: true, 
//           //runs when a code is typed in
//           onCodeChanged: (String code) {
//               //handle validation or checks here           
//           },
//           //runs when every textfield is filled
//           onSubmit: (String verificationCode){
//               showDialog(
//                   context: context,
//                   builder: (context){
//                   return AlertDialog(
//                       title: Text("Verification Code"),
//                       content: Text('Code entered is $verificationCode'),
//                   );
//                   }
//               );
//           }, // end onSubmit
//       ),
//     );
//   }
// }