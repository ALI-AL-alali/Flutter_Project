import 'package:ev_power/Services/Cars.dart';
import 'package:ev_power/widgets/mybutton2.dart';
import 'package:ev_power/widgets/input.dart';
import 'package:flutter/material.dart';

class CreatCarScreen extends StatefulWidget {
  const CreatCarScreen({super.key});

  @override
  State<CreatCarScreen> createState() => _CreatCarScreenState();
}

class _CreatCarScreenState extends State<CreatCarScreen> {
  // ignore: non_constant_identifier_names
  String? CarType;
  // ignore: non_constant_identifier_names
  final TextEditingController car_number = TextEditingController();
  bool _isLoading = false;

  Future<void> _addcar() async {
    if (CarType == null && car_number.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى ادخال البيانات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (CarType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى اختيار نوع الشحن',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (car_number.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى إدخال رقم السيارة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    try {
      if (mounted) setState(() => _isLoading = true);

      final result = await CarsApi.addCar(
        carnumber: car_number.text,
        cartype: CarType!,
      );

      if (result['success'] == true) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'user_screen');
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message'] ?? 'حدث خطأ أثناء حفظ البيانات',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currenwidth = MediaQuery.of(context).size.width;
    final currenheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
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
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 127, 230),
          ),
          body: Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 0, 127, 230),
                    Colors.indigo,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: currenheight < 610 ? 140 : 200,
                          child: Image.asset('images/1.png'),
                        ),
                        const Text(
                          'هيا نضيف معلومات سيارتك',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: currenheight < 650
                          ? currenheight * 0.2
                          : currenheight,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            currenheight < 610
                                ? const SizedBox(height: 10)
                                : const SizedBox(height: 30),
                            Input(
                              text: 'رقم سيارة',
                              mycontroller: car_number,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى ادخال الرقم';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                            const Text('نوع الشحن المدعوم بالسيارة'),
                            const SizedBox(height: 20),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('بطيء'),
                                  Radio(
                                    activeColor: Colors.green,
                                    value: 'Slow',
                                    groupValue: CarType,
                                    onChanged: (val) {
                                      setState(() {
                                        CarType = val;
                                      });
                                    },
                                  ),
                                  const Text('سريع'),
                                  Radio(
                                    activeColor: Colors.green,
                                    value: 'Fast',
                                    groupValue: CarType,
                                    onChanged: (val) {
                                      setState(() {
                                        CarType = val;
                                      });
                                    },
                                  ),
                                  const Text('كلاهما'),
                                  Radio(
                                    activeColor: Colors.green,
                                    value: 'Both',
                                    groupValue: CarType,
                                    onChanged: (val) {
                                      setState(() {
                                        CarType = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            currenheight < 650
                                ? const SizedBox(height: 5)
                                : const SizedBox(height: 30),
                            MyButton2(
                              Title:
                                  _isLoading ? 'جاري التحميل...' : 'حفظ بيانات',
                              color: Colors.blue,
                              onPressed: _addcar,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.only(top: 20),
            child: const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 2, 207, 9),
            )),
          ),
      ],
    );
  }
}
