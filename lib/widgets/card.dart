import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Card2 extends StatelessWidget {
  Card2({
    required this.text,
    required this.asset,
    required this.f,
    super.key,
    required this.color1,
    required this.color2,
    required this.suptitle,
    required this.anmaition,
  });
  final String text;
  final String asset;
  final VoidCallback f;
  final Color color1;
  final Color color2;
  final String suptitle;
  final bool anmaition;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: f,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [color1, color2])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: anmaition == true
                          ? Lottie.asset(asset)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                asset,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ))),
                  Expanded(
                    child: Wrap(
                        runAlignment: WrapAlignment.center,
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  text,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  suptitle,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )
                              ])
                        ]),
                  ),
                  const SizedBox(
                    width: 12,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
