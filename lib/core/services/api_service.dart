import 'dart:convert';
import 'package:doodle/core/utils/app_constants.dart';
import 'package:doodle/core/connection/basehttp_servcie.dart';
import 'package:dartz/dartz.dart';
import 'package:doodle/models/login_model.dart';
import 'package:doodle/models/register_model.dart';
import 'package:doodle/models/user.dart';
import 'package:doodle/core/db/sharedPref/shared_pref_helper.dart';

class ApiService extends BaseHttpService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  Future<Either<String, LoginModel>> login(
      String email, String password) async {
    final url = '${ApiConstants.baseUrl}login';
    try {
      final response = await post(url, _headers, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final model = LoginModel.fromJson(json);
        await SharedPrefHelper.saveToken(model.token ?? '');
        return Right(model);
      } else {
        return Left('Failed to login');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, RegisterModel>> register(
      String email, String password) async {
    final url = '${ApiConstants.baseUrl}register';
    try {
      final response = await post(url, _headers, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final model = RegisterModel.fromJson(json);
        await SharedPrefHelper.saveToken(model.token ?? '');
        return Right(model);
      } else if (response.statusCode == 400) {
        return Left(jsonDecode(response.body)['error'] ?? 'Bad request');
      } else {
        return Left('Failed to register');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, UserResponseModel>> getUsers(int page) async {
    final url = '${ApiConstants.baseUrl}users?page=$page';
    try {
      final response = await get(url, _headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final model = UserResponseModel.fromJson(json);
        return Right(model);
      } else {
        return Left('Failed to load users');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
