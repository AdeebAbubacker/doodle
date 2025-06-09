import 'package:doodle/core/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RegsiterState { initial, loading, success, failure, userNotinDb }

class RegisterCubit extends Cubit<RegsiterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegsiterState.initial);

  Future<void> regsiter(String email, String password) async {
    emit(RegsiterState.loading);
    try {
      final data = await _apiService.register(email, password);
      if (data['token'] != null) {
        emit(RegsiterState.success);
      } else if (data['error'] != null &&
          data['error']
              .toString()
              .contains('Only defined users succeed registration')) {
        // specific error detected
        emit(RegsiterState.userNotinDb);
      } else {
        emit(RegsiterState.failure);
      }
    } catch (e) {
      emit(RegsiterState.failure);
    }
  }
}
