import 'package:ev_power/widgets/mycard.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
          child: Container( width: double.infinity,
            decoration: const BoxDecoration(
               color: const Color.fromARGB(255, 0, 127, 230),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child:
                
                   GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[Mycard('معلومات حسابي', 'asset/user.json', (){ Navigator.pushNamed(
                                  context, 'account_scren');}),
                        Mycard('محطات الشحن', 'asset/station.json',(){ Navigator.pushNamed(
                                  context, 'Select_Stations_scren');}),
                        Mycard('سيارة مفعلة', 'asset/cars.json',(){ Navigator.pushNamed(
                                  context, 'selectcar_scren');}),
                        Mycard('حالة طارئة', 'asset/22.json',(){ Navigator.pushNamed(
                                  context, 'CreatAccount_scren');}),  Mycard(' حالةالحجز', 'asset/11.json',(){ Navigator.pushNamed(
                                  context, 'CreatAccount_scren');}), Mycard('تسجيل الخروج', 'asset/logout.json',(){ Navigator.pushNamed(
                                  context, 'CreatAccount_scren');})
                      ]),),),)
               ,
              ],
            ),
          ),
        ));
  }
}
