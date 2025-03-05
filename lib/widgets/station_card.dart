import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StationCard extends StatelessWidget {
  StationCard(this.text, this.addres, this.f, this.color1, this.color2, this.image);
  final String text;
  final String addres;
  final VoidCallback f;
  final Color color1;
  final Color color2;
   final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
             color1,color2
            ]),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 17), blurRadius: 20, spreadRadius: -24)
            ],
            borderRadius: BorderRadius.circular(13)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(image,
                repeat: true, animate: true, height: 200, width: 120),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    addres,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
