import 'dart:io';
import 'package:ev_power/Services/auth_api.dart';
import 'package:ev_power/widgets/mybutton2.dart';
import 'package:ev_power/widgets/input2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ignore: camel_case_types
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تنبيه'),
            content: const Text('لا يمكنك استخدام التطبيق دون تشغيل الموقع'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
                },
                child: const Text("حسنا"),
              ),
            ],
          );
        },
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else {
        exit(0);
      }
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _onBackPressed() async {
    bool? exitConfirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تنبيه'),
        content: const Text('هل تريد الخروج من التطبيق؟'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            onPressed: () => Navigator.pop(context, false),
            child: const Text("لا"),
          ),
          TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context, true);
                SystemNavigator.pop();
              },
              child: const Text("نعم")),
        ],
      ),
    );

    return exitConfirmed ?? false;
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@') ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى ملء جميع الحقول بشكل صحيح',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      //امسحها بعدين بعد ربط القاعدة
      // await Future.delayed(const Duration(seconds: 2));

      final result = await ApiService.login(
          _emailController.text, _passwordController.text);
      if (result['success'] == true) {
        final token = await ApiService.getToken();
        if (token != null && mounted) {
          Navigator.pushReplacementNamed(context, 'user_screen');
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                result['error'] ?? 'حدث خطأ أثناء تسجيل الدخول',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['error'] ?? 'بيانات تسجيل الدخول غير صحيحة',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final currenwidth = MediaQuery.of(context).size.width;
    final currenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Stack(
          children: [
            Container(
              height: currenheight,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.indigo,
                   Color.fromARGB(255, 0, 127, 230),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            currenwidth < 400
                                ? SizedBox(
                                    width: currenwidth * 0.39,
                                    child: Expanded(
                                      child: Container(
                                          child: Lottie.asset('asset/2.json')),
                                    ),
                                  )
                                : SizedBox(
                                    width: currenwidth * 0.49,
                                    child: Expanded(
                                      child: Container(
                                          child: Lottie.asset('asset/2.json')),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: currenheight * 0.6,
                      child: Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(204, 224, 224, 224),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Input2(
                                        title: 'البريد الإلكتروني',
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إدخال البريد الإلكتروني';
                                          }
                                          if (!value.contains('@')) {
                                            return 'البريد الإلكتروني غير صحيح';
                                          }
                                          return null;
                                        },
                                      ),
                                      Input2(
                                        title: 'كلمة السر',
                                        controller: _passwordController,
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
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'forget_password_screen');
                                      },
                                      child: const Text(
                                        "نسيت كلمة السر؟",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, 'register_screen');
                                      },
                                      child: const Text(
                                        " أنشاء حساب",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: currenheight < 550 ? 10 : 20),
                                MyButton2(
                                  Title: _isLoading
                                      ? 'جاري التحميل...'
                                      : 'تسجيل الدخول',
                                  color: Colors.indigo,
                                  onPressed:
                                      _login, //Api وقت افعل ال _login لازم اكتب هون
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.only(top: 20),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 9, 2, 207),
                )),
              ),
          ],
        ),
      ),
    );
  }
}
