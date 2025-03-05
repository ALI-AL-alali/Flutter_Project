import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl =
      "http://192.168.1.109:8000/api";

  // تسجيل مستخدم جديد
  static Future<Map<String, dynamic>> register(
      String name, String email, String password,String phone_number) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone_number' : phone_number,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        await _saveToken(responseData['token']); // حفظ التوكن
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'error': responseData['message'] ?? 'فشل التسجيل'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'خطأ في الاتصال: $e'};
    }
  }

  // تسجيل الدخول
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'), // استخدام baseUrl
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await _saveToken(responseData['token']); // حفظ التوكن
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'error': responseData['message'] ?? 'فشل تسجيل الدخول'
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'خطأ في الاتصال: $e'};
    }
  }

  // حفظ التوكن محليًا
  static Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // جلب التوكن المحفوظ
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // تسجيل الخروج
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
