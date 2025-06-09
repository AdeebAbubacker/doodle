import 'package:doodle/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {}

class UserCubit extends Cubit<UserState> {
  final ApiService _apiService;

  UserCubit(this._apiService) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    try {
      final data = await _apiService.getUsers(2);
      final users = data.map((u) => User.fromJson(u)).toList();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError());
    }
  }
}
