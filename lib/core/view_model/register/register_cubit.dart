import 'package:doodle/core/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum RegsiterState { initial, loading, success, failure }

class RegisterCubit extends Cubit<RegsiterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegsiterState.initial);

  Future<void> regsiter(String email, String password) async {
    emit(RegsiterState.loading);
    try {
      final data = await _apiService.register(email, password);
      if (data['token'] != null) {
        emit(RegsiterState.success);
      } else {
        emit(RegsiterState.failure);
      }
    } catch (e) {
      emit(RegsiterState.failure);
    }
  }
}
