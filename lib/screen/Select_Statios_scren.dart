import 'package:ev_power/widgets/mycard.dart';
import 'package:ev_power/widgets/station_card.dart';
import 'package:flutter/material.dart';

class SelectStatiosScren extends StatelessWidget {
  SelectStatiosScren({super.key});
  List<dynamic> l = ['معلومات', () {}, ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(height: 10, child: Image.asset('images/ev.png')),
          ),
          centerTitle: true,
          title: const Text(
            'EV_POWER',
            style: TextStyle(
                color: Color.fromARGB(255, 231, 222, 222),
                fontSize: 30,
                fontWeight: FontWeight.w400),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 127, 230),
        ),
        body: Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 0, 127, 230),
                ),
                child: Column(children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: ListView(
                         children: [  Padding(
                            padding: const EdgeInsets.all(25),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(margin: EdgeInsets.only(bottom: 10),
                                  width: 200,height: 200,
                                  child: StationCard('محطة الشحن السريع', 'الرياض، حي المالكات',(){ Navigator.pushNamed(
                                  context, 'station');}, Color.fromARGB(255, 0, 127, 230),
              Color.fromARGB(255, 51, 192, 8),'asset/caronstret.json'),
                                );
                              },
                            ),
                          ),]
                        )),
                  ),
                ]))));
  }
}
