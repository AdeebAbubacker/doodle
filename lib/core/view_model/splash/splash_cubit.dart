import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { initial, loaded }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

  Future<void> loadSplash() async {
    await Future.delayed(Duration(seconds: 2));
    emit(SplashState.loaded);
  }
}
