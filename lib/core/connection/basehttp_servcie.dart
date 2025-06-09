import 'dart:convert';
import 'package:doodle/core/connection/connectivity_checker.dart';
import 'package:http/http.dart' as http;

abstract class BaseHttpService {
  final ConnectivityChecker _connectivityChecker = ConnectivityChecker();

  Future<http.Response> get(String url, Map<String, String> headers) async {
    await _ensureInternet();
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> post(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    await _ensureInternet();
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<void> _ensureInternet() async {
    final hasInternet = await _connectivityChecker.hasInternetAccess();
    if (!hasInternet) {
      throw Exception('No internet');
    }
  }
}
