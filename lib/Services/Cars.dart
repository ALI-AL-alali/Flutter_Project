import 'package:ev_power/Model/Car.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CarsApi {
  static const String baseUrl = "http://192.168.250.78:8000/api";

  static Future<Map<String, dynamic>> addCar({
    required String carnumber,
    required String cartype,
  }) async {
    if (carnumber.isEmpty || cartype.isEmpty) {
      return {
        'success': false,
        'message': 'يرجى ملء جميع الحقول',
      };
    }

    final url = Uri.parse('$baseUrl/createcar');

    try {
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');
      Map<String, dynamic> user = jsonDecode(userJson!);
      String? userId = user['id'].toString();
      if (userId == null) {
        return {
          'success': false,
          'message': 'معرّف المستخدم غير موجود',
        };
      }
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'UserId': userId,
          'CarNumber': carnumber,
          'VehicleType': cartype,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'فشل في الحفظ',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ في الاتصال: $e',
      };
    }
  }

  static Future<List<Car>> getCars() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');
      if (userJson == null) {
        throw Exception('بيانات المستخدم غير موجودة');
      }
      Map<String, dynamic> user = jsonDecode(userJson);
      String? userId = user['id'].toString();
      if (userId == null) {
        throw Exception('معرّف المستخدم غير موجود');
      }

      final url = Uri.parse('$baseUrl/vehicles').replace(
        queryParameters: {'user_id': userId},
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['cars'] as List)
            .map((carJson) => Car.fromJson(carJson))
            .toList();
      } else {
        throw Exception('Failed to load cars: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}
