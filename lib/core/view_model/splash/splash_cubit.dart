import 'package:reqres/core/db/sharedPref/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { initial, navigateToLogin, navigateToHome }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

  Future<void> loadSplash() async {
    await Future.delayed(Duration(seconds: 2));

    final hasToken = await SharedPrefHelper.isLoggedIn();

    if (hasToken) {
      emit(SplashState.navigateToHome);
    } else {
      emit(SplashState.navigateToLogin);
    }
  }
}
