import 'dart:convert';
import 'package:doodle/core/utils/app_constants.dart';
import 'package:doodle/core/connection/basehttp_servcie.dart';

class ApiService extends BaseHttpService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '${ApiConstants.baseUrl}login';
    try {
      final response = await post(url, _headers, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = '${ApiConstants.baseUrl}register';
    try {
      final response = await post(url, _headers, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getUsers(int page) async {
    final url = '${ApiConstants.baseUrl}users?page=$page';
    try {
      final response = await get(url, _headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      rethrow;
    }
  }
}
