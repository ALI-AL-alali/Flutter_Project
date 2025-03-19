import 'package:ev_power/screen/auth/forget_password_screen.dart';
import 'package:ev_power/screen/auth/verify_screen.dart';
import 'package:ev_power/screen/select_statios_screen.dart';
import 'package:ev_power/screen/station_screen.dart';
import 'package:ev_power/screen/account_screen.dart';
import 'package:ev_power/screen/auth/register_screen.dart';
import 'package:ev_power/screen/create_car_screen.dart';
import 'package:ev_power/screen/auth/login_screen.dart';
import 'package:ev_power/screen/select_car_screen.dart';
import 'package:ev_power/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    runApp(MyApp(token: token));
  });
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //
        initialRoute: token == null ? 'login_screen' : 'user_screen',
        routes: {
          'login_screen': (context) => const LoginScreen(),
          'register_screen': (context) => const RegisterScreen(),
          'user_screen': (context) => const UserScreen(),
          'stationscreen': (context) => const StationScreen(),
          'select_stations_screen': (context) => SelectStatiosScreen(),
          'create_car_screen': (context) => const CreatCarScreen(),
          'select_car_screen': (context) => const SelectcarScreen(),
          'account_screen': (context) => const AccountScreen(),
          'forget_password_screen': (context) => const ForgetPasswordScreen(),
          // 'verify_screen': (context) => const VerifyScreen(),
        });
  }
}
