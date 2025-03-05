import 'package:ev_power/widgets/input.dart';
import 'package:ev_power/widgets/MyButton2.dart';
import 'package:flutter/material.dart';

class CreatcarScren extends StatefulWidget {
  const CreatcarScren({super.key});

  @override
  State<CreatcarScren> createState() => _CreatcarScrenState();
}

class _CreatcarScrenState extends State<CreatcarScren> {
  String? CarType;
  final TextEditingController car_number = TextEditingController();

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
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 0, 127, 230),
              Color.fromARGB(255, 51, 192, 8),
            ])),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(height: 200, child: Image.asset('images/1.png')),
                    const Text(
                      'هيا نضيف  معلومات سيارتك',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Input(text: 'رقم سيارة',mycontroller: car_number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يرجى ادخال الرقم';
                                  }
                                  return null;
                                }),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                'نوع الشحن المدعوم بالسيارة',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('بطيء'),
                                    Radio(
                                        activeColor: Colors.green,
                                        value: 'Slow',
                                        groupValue: CarType,
                                        onChanged: (val) {
                                          setState(() {
                                            CarType = val;
                                          });
                                        }),
                                    Text('سريع'),
                                    Radio(
                                        activeColor: Colors.green,
                                        value: 'Fast',
                                        groupValue: CarType,
                                        onChanged: (val) {
                                          setState(() {
                                            CarType = val;
                                          });
                                        }),
                                    Text('كلاهما'),
                                    Radio(
                                        activeColor: Colors.green,
                                        value: 'Both',
                                        groupValue: CarType,
                                        onChanged: (val) {
                                          setState(() {
                                            CarType = val;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              MyButton2(
                                  Title: 'حفظ بيانات',
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'user_scren');
                                  })
                            ],
                          ))),
                )
              ],
            ),
          ),
        ));
  }
}
