import 'package:reqres/core/services/api_service.dart';
import 'package:reqres/core/view_model/login/login_cubit.dart';
import 'package:reqres/core/view_model/register/register_cubit.dart';
import 'package:reqres/core/view_model/user/user_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerFactory(() => RegisterCubit(getIt<ApiService>()));
  getIt.registerFactory(() => LoginCubit(getIt<ApiService>()));
  getIt.registerFactory(() => UserCubit(getIt<ApiService>()));
}
