import 'package:doodle/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class NoInternetFailure extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

class LoginNoInternet extends LoginState {}

class LoginCubit extends Cubit<LoginState> {
  final ApiService _apiService;

  LoginCubit(this._apiService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final result = await _apiService.login(email, password);

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(LoginNoInternet());
        } else {
          emit(LoginFailure(failure));
        }
      },
      (data) {
        if (data.token != null) {
          emit(LoginSuccess(data));
        } else {
          emit(LoginFailure('Invalid credentials'));
        }
      },
    );
  }
}
