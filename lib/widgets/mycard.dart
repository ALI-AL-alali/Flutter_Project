import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Mycard extends StatelessWidget {
  Mycard(this.text, this.image, this.f);
  final String text;
  final String image;
  final VoidCallback f;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: f,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(offset: Offset(0, 17), blurRadius: 20, spreadRadius: -24)
        ], color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: Column(
          children: <Widget>[
            Spacer(),
            Lottie.asset(image),
            Spacer(),
            Text(
              text,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
// return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Card(
//           child: Column(
//         children: [
//           Image.asset(image),
//           Text(
//             text,
//             style: const TextStyle(
//                 color: Color(0xff2e386b),
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold),
//           )