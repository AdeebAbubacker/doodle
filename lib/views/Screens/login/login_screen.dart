import 'package:doodle/core/view_model/login/login_cubit.dart';
import 'package:doodle/views/widget/custom_button.dart';
import 'package:doodle/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(
    text: "eve.holt@reqres.in",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "pistol",
  );

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state == LoginState.success) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state == LoginState.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed')),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    'assets/help.png',
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),

                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                // Login Button
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                              emailController.text,
                              passwordController.text,
                            );
                      },
                      label: 'Login',
                      isLoading: state == LoginState.loading,
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Register prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
