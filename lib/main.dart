import 'package:ev_power/screen/Select_Statios_scren.dart';
import 'package:ev_power/screen/Station_scren.dart';
import 'package:ev_power/screen/account_scren.dart';
import 'package:ev_power/screen/register_screen.dart';
import 'package:ev_power/screen/creatCar_scren.dart';
import 'package:ev_power/screen/login_screen.dart';
import 'package:ev_power/screen/selectcar_scren.dart';
import 'package:ev_power/screen/user_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
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
        initialRoute: 'login_screen',
        routes: {
          'login_screen': (context) => const LoginScreen(),
          'user_scren': (context) => const UserScreen(),
          'station': (context) => Station_scren(),
          'register_screen': (context) => RegisterScreen(),
          'Select_Stations_scren': (context) => SelectStatiosScren(),
          'CREATCAR_SCREN':(context) => const CreatcarScren(),
          'account_scren':(context) =>const AccountScren(),
          'selectcar_scren':(context) =>const SelectcarScren()
        });
  }
}
