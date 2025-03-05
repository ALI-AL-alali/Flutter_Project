import 'package:ev_power/Services/auth_api.dart';
import 'package:ev_power/widgets/input.dart';
import 'package:ev_power/widgets/MyButton2.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneNumberController.text,
      );

      if (result['success'] == true) {
        final token = await ApiService.getToken();
        if (token != null && mounted) {
          Navigator.pushReplacementNamed(context, 'user_scren');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error'] ?? 'فشل في التسجيل'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset('images/ev.png', fit: BoxFit.contain),
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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 0, 127, 230),
              Color.fromARGB(255, 51, 192, 8),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset('images/icon2.png'),
                  ),
                  const Text(
                    'هيا نبدأ بإنشاء حسابك',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Input(
                            text: 'الاسم الكامل',
                            mycontroller: _usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال الاسم الكامل';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Input(
                            text: 'البريد الإلكتروني',
                            mycontroller: _emailController,
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
                          const SizedBox(height: 15),
                          Input(
                            text: 'كلمة المرور',
                            mycontroller: _passwordController,
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
                          const SizedBox(height: 15),
                          Input(
                            text: 'رقم الجوال',
                            mycontroller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال رقم الجوال';
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'رقم الجوال يجب أن يتكون من 10 أرقام';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          MyButton2(
                            Title:
                                _isLoading ? 'جاري التحميل...' : 'تسجيل الدخول',
                            color: const Color.fromARGB(255, 0, 127, 230),
                            onPressed: _register,
                          ),
                          if (_isLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
