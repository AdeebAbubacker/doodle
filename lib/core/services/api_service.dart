import 'package:dio/dio.dart';
import 'package:doodle/core/utils/constants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.apiKey,
      },
    ),
  );

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post(
      'login',
      data: {'email': email, 'password': password},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await _dio.post(
      'register',
      data: {'email': email, 'password': password},
    );
    return response.data;
  }

  Future<List<dynamic>> getUsers(int page) async {
    final response = await _dio.get('users', queryParameters: {'page': page});
    return response.data['data'];
  }
}
