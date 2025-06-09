import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';

enum LoginState { initial, loading, success, failure }

class LoginCubit extends Cubit<LoginState> {
  final ApiService _apiService;

  LoginCubit(this._apiService) : super(LoginState.initial);

  Future<void> login(String email, String password) async {
    emit(LoginState.loading);
    try {
      final data = await _apiService.login(email, password);
      if (data['token'] != null) {
        emit(LoginState.success);
      } else {
        emit(LoginState.failure);
      }
    } catch (e) {
      emit(LoginState.failure);
    }
  }
}
