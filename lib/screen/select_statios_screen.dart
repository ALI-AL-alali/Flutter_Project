import 'package:ev_power/widgets/card.dart';
import 'package:ev_power/widgets/station_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectStatiosScreen extends StatelessWidget {
  SelectStatiosScreen({super.key});
  List<dynamic> l = ['معلومات', () {}, ''];
  @override
  Widget build(BuildContext context) {
    final currenwidth = MediaQuery.of(context).size.width;
    final currenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(height: 10, child: Image.asset('images/ev.png')),
          ),
          centerTitle: true,
          title: const Text(
            'EV_POWER',
            style: TextStyle(
                color: Color.fromARGB(255, 231, 222, 222),
                fontSize: 30,
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Column(children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Card2(
                                  text: 'محطة الشحن السريع',
                                  asset: "images/station3.jpg",
                                  f: () {
                                    Navigator.pushNamed(context, 'stationscreen');
                                  },
                                  color1: Colors.indigoAccent,
                                  color2: Colors.black,
                                  suptitle: 'الرياض، حي المالكات',
                                  anmaition: false,
                                );
                              },
                              // Container(
                              //     margin: const EdgeInsets.only(bottom: 10),
                              //     width: 200,
                              //     height: 200,
                              //     child: StationCard('محطة الشحن السريع',
                              //         'الرياض، حي المالكات', () {
                              //       Navigator.pushNamed(context, 'station');
                              //     },
                              //         const Color.fromARGB(255, 0, 127, 230),
                              //         const Color.fromARGB(255, 51, 192, 8),
                              //         'asset/caronstret.json',
                              //         currenwidth < 370 ? 160 : 200),
                              //   );
                            ),
                          ),
                        ])),
                  ),
                ]))));
  }
}
