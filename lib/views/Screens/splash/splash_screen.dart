import 'package:doodle/core/view_model/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.green.shade600;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state == SplashState.loaded) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        backgroundColor: themeColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    'assets/splash_logo.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                // Image.asset(
                //   'assets/splash_logo.png',
                //   height: 120,
                //   fit: BoxFit.contain,
                //   color: Colors.white,
                // ),

                const SizedBox(height: 32),

                // App name
                Text(
                  "Reqres CRM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 40),

                // Subtext or tagline (optional)
                Text(
                  "Simplify your customer relationships",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 48),

                // Loader
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
