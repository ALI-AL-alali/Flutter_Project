// import 'package:ev_power/widgets/MyButton.dart';
// import 'package:ev_power/widgets/input.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// import 'package:lottie/lottie.dart';
// class SingInScren extends StatefulWidget {
//   const SingInScren({super.key});

//   @override
//   State<SingInScren> createState() => _SingInScrenState();
// }

// class _SingInScrenState extends State<SingInScren> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     height: 200,
//                     child: Image.asset('images/icon1.png'),
//                   ),
//                   const Text(
//                     "EV_Power",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Color(0xff2e386b),
//                         fontWeight: FontWeight.w800),
//                   )
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Input(
//                     text: 'enter your Name',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Input(
//                     text: 'enter your Email',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Input(
//                     text: 'enter your Password',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Input(
//                     text: 'enter your CarNambuer',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                    MyButton(Colors.blue, 'creat Account',(){})
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
