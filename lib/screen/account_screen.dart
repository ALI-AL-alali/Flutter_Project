import 'package:ev_power/widgets/mybutton2.dart';
import 'package:ev_power/widgets/input2.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController username = TextEditingController();
    final TextEditingController phoneNumber = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController passwordnew = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 10,
            child: Image.asset('images/ev.png'),
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 260,
                  child: Image.asset('images/icon1.png'),
                ),
                const Text(
                  'معلومات حسابك',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 20),
                    Input2(
                      title: 'الاسم الكامل',
                      controller: username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الاسم ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input2(
                      title: 'رقم الهاتف',
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الهاتف';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input2(
                      title: 'كلمة السر الحالية',
                      controller: password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value.length < 8) {
                          return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input2(
                      title: 'كلمة السر الجديدة',
                      controller: passwordnew,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value.length < 8) {
                          return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Input2(
                      title: 'كلمة السر الجديدة',
                      controller: confirmPassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value != passwordnew.text) {
                          return 'كلمة السر غير مطتابقة مع الكلمة الجديدة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    MyButton2(
                      Title: 'تغيير كلمة السر',
                      color: Colors.blue,
                      onPressed: () {
                        // إضافة وظيفة لتغيير كلمة المرور هنا
                        Navigator.pushNamed(context, 'user_screen');
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
