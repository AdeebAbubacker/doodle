// http_client_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:doodle/core/connection/connectivity_checker.dart';
import 'package:http/http.dart' as http;

class HttpClientService {
  final Map<String, String> headers;
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  HttpClientService({required this.headers});

  Future<dynamic> get(String url) async {
    return _safeRequest(() async {
      final response = await http.get(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    });
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    return _safeRequest(() async {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return _handleResponse(response);
    });
  }

  Future<T> _safeRequest<T>(Future<T> Function() request) async {
    final hasInternet = await _connectivityChecker.hasInternetAccess();
    if (!hasInternet) throw Exception('No internet connection');
    try {
      return await request();
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    print('Handling response...');
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Response success");
      return decoded;
    } else {
      print("Response failure");
      throw Exception(decoded['error'] ?? 'Unexpected error');
    }
  }
}
