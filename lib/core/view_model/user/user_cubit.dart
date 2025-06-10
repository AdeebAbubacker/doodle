import 'package:dartz/dartz.dart';
import 'package:reqres/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserNoInternet extends UserState {}

class UserLoaded extends UserState {
  final UserResponseModel users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserCubit extends Cubit<UserState> {
  final ApiService _apiService;

  UserCubit(this._apiService) : super(UserInitial());

  Future<void> fetchUsers(int page) async {
    emit(UserLoading());

    try {
      final Either<String, UserResponseModel> result =
          await _apiService.getUsers(page);

      result.fold(
        (failure) {
          if (failure.contains('No internet')) {
            emit(UserNoInternet());
          } else {
            emit(UserError(failure));
          }
        },
        (data) {
          emit(UserLoaded(data));
        },
      );
    } catch (e) {
      emit(UserError('Unexpected error: $e'));
    }
  }
}
