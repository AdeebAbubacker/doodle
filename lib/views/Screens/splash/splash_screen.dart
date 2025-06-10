import 'package:doodle/core/const/colors.dart';
import 'package:doodle/core/const/text_styles.dart';
import 'package:doodle/core/view_model/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state == SplashState.navigateToHome) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state == SplashState.navigateToLogin) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.greenTheme,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/splash_logo.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Reqres CRM",
                  style: AppTextStyles.whiteWboldS32,
                ),
                const SizedBox(height: 40),
                Text(
                  "Simplify your customer relationships",
                  style: AppTextStyles.whiteW400S16,
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
