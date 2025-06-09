import 'package:doodle/core/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String token;
  RegisterSuccess(this.token);
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);
}

class RegisterNoInternet extends RegisterState {}

class RegisterUserNotInDb extends RegisterState {}

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());

    try {
      final Either<String, Map<String, dynamic>> result =
          await _apiService.register(email, password);

      result.fold(
        (failure) {
          if (failure.contains('No internet')) {
            emit(RegisterNoInternet());
          } else if (failure
              .contains('Note: Only defined users succeed registration')) {
            emit(RegisterUserNotInDb());
          } else {
            emit(RegisterFailure(failure));
          }
        },
        (data) {
          if (data['token'] != null) {
            emit(RegisterSuccess(data['token']));
          } else {
            emit(RegisterFailure('Invalid response from server'));
          }
        },
      );
    } catch (e) {
      emit(RegisterFailure('Unexpected error: $e'));
    }
  }
}
