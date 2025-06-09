import 'package:dartz/dartz.dart';
import 'package:doodle/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';


abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserNoInternet extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

// Cubit
class UserCubit extends Cubit<UserState> {
  final ApiService _apiService;

  UserCubit(this._apiService) : super(UserInitial());

  Future<void> fetchUsers(int page) async {
    emit(UserLoading());

    try {
      // Assuming your ApiService.getUsers returns Either<String, List<dynamic>>
      final Either<String, List<dynamic>> result = await _apiService.getUsers(page);

      result.fold(
        (failure) {
          if (failure.contains('No internet')) {
            emit(UserNoInternet());
          } else {
            emit(UserError(failure));
          }
        },
        (data) {
          final users = data.map((u) => User.fromJson(u)).toList();
          emit(UserLoaded(users));
        },
      );
    } catch (e) {
      emit(UserError('Unexpected error: $e'));
    }
  }
}
