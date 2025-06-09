import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';

enum RegsiterState { initial, loading, success, failure }

class RegisterCubit extends Cubit<RegsiterState> {
  final ApiService _apiService;

  RegisterCubit(this._apiService) : super(RegsiterState.initial);

  Future<void> login(String email, String password) async {
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
