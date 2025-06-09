import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doodle/core/utils/constants.dart';

class ApiService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}login');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}register');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<List<dynamic>> getUsers(int page) async {
    final url = Uri.parse('${ApiConstants.baseUrl}users?page=$page');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load users');
    }
  }
}
