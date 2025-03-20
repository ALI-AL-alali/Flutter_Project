import 'package:ev_power/widgets/card.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late int currten = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.indigo,
          currentIndex: currten,
          onTap: (value) {
            setState(() {
              currten = value;
            });
          },
          selectedFontSize: 20,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "الصفحة الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2), label: "الملف الشخصي"),
          ]),
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
          decoration: const BoxDecoration(color: Colors.indigo),
          child: Column(
            children: [
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
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              SizedBox(
                                height: 200,
                                child: Card2(
                                  text: 'حالةالحجز',
                                  asset: 'asset/11.json',
                                  f: () {
                                    Navigator.pushNamed(
                                        context, 'account_screen');
                                  },
                                  color1: Colors.indigo,
                                  color2: Colors.black,
                                  suptitle:
                                      "استمتع بخاصية مراجعة حالة الحجز الخاص بك بكل يسر وسهولة مع معرفة التوقيت والتاريخ بدقة",
                                  anmaition: true,
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: Card2(
                                    text: 'محطات الشحن',
                                    asset: 'asset/station.json',
                                    f: () {
                                      Navigator.pushNamed(
                                          context, 'select_stations_screen');
                                    },
                                    color1: Colors.indigo,
                                    color2: Colors.black,
                                    suptitle:
                                        "اختيار وحجز محظة الشحن المفضلة لك بسهولة ويسر",
                                    anmaition: true),
                              ),
                              SizedBox(
                                height: 200,
                                child: Card2(
                                    text: 'حالة طارئة',
                                    asset: 'asset/22.json',
                                    f: () {
                                      Navigator.pushNamed(
                                          context, 'user_screen');
                                    },
                                    color1: Colors.indigo,
                                    color2: Colors.black,
                                    suptitle:
                                        "تعرف على كيفية التعامل  مع حالات الطورئ لشحن السيارات الكهربائية أثناء السفر",
                                    anmaition: true),
                              ),

                              // Mycard('محطات الشحن', 'asset/station.json', () {
                              //   Navigator.pushNamed(
                              //       context, 'Select_Stations_scren');
                              // }),
                              // Mycard('سيارة مفعلة', 'asset/cars.json', () {
                              //   Navigator.pushNamed(context, 'selectcar_scren');
                              // }),
                              // Mycard('حالة طارئة', 'asset/22.json', () {
                              //   Navigator.pushNamed(
                              //       context, 'CreatAccount_scren');
                              // }),
                              // Mycard(' حالةالحجز', 'asset/11.json', () {
                              //   Navigator.pushNamed(
                              //       context, 'CreatAccount_scren');
                              // }),
                              // Mycard('تسجيل الخروج', 'asset/logout.json', () {
                              //   Navigator.pushNamed(
                              //       context, 'CreatAccount_scren');
                              // })
                            ]);
                          }),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
