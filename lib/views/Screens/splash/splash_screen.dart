import 'package:doodle/core/view_model/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..loadSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.loaded) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
