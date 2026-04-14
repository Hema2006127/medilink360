import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // للآندرويد الحقيقي عبر الواي فاي، نستخدم الـ IP الخاص بجهاز الكمبيوتر
  static const String baseUrl = 'http://192.168.1.12:8000';

  /// تسجيل الدخول (Login)
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email.trim(), 'password': password}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body); // {message: "...", access_token: "...", user: {...}}
      } else {
        // في حالة الخطأ
        final error = json.decode(response.body);
        throw Exception(error['detail'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// إنشاء حساب جديد (Register)
  static Future<Map<String, dynamic>?> register(String email, String password, String name, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email.trim(),
          'password': password,
          'full_name': name,
          'role': role
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // {message: "User registered..."}
      } else {
        final error = json.decode(response.body);
        
        throw Exception(error['detail'] ?? 'Registration failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// جلب بيانات الحساب (Profile)
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); 
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
