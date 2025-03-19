// import 'package:ev_power/widgets/MyButton.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:lottie/lottie.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Column(
//             children: [
//               // Image.asset('images/2.png'),
//               Lottie.asset('asset/2.json'),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "EV_Power",
//                 style: TextStyle(
//                     fontSize: 34,
//                     color: Color(0xff2e386b),
//                     fontWeight: FontWeight.w800),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           MyButton(Colors.blue[800]!, 'sing_in', () {
//             Navigator.pushNamed(context, 'S');
//           }),
//           const SizedBox(
//             height: 10,
//           ),
//           MyButton(Colors.green, 'register', () {
//             Navigator.pushNamed(context, 'user_screen');
//           }),
//         ],
//       ),
//     ));
//   }
// }
