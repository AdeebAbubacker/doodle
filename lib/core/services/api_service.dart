import 'dart:convert';
import 'package:doodle/core/connection/connectivity_checker.dart';
import 'package:http/http.dart' as http;
import 'package:doodle/core/utils/app_constants.dart';

class ApiService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}login');
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        throw Exception('No internet');
      }

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
    } catch (e) {
      // Rethrow the original exception so cubit can catch it properly
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}register');
    try {
      final hasInternet = await _connectivityChecker.hasInternetAccess();
      if (!hasInternet) {
        throw Exception('No internet');
      }

      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        // decode and return error message
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      // Rethrow the original exception so cubit can catch it properly
      rethrow;
    }
  }

  Future<List<dynamic>> getUsers(int page) async {
    final url = Uri.parse('${ApiConstants.baseUrl}users?page=$page');
    final response = await http.get(url, headers: _headers);
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      // Rethrow the original exception so cubit can catch it properly
      rethrow;
    }
  }
}
