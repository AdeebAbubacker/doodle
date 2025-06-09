import 'package:doodle/core/const/text_styles.dart';
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
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state == LoginState.success) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state == LoginState.noInternet) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No Internet')),
              );
            } else if (state == LoginState.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed ${state.name}')),
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/help.png',
                      height: MediaQuery.sizeOf(context).height * 0.20,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'Welcome Back',
                    style: AppTextStyles.blackW700S26,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: AppTextStyles.blackW500S16,
                  ),
                  const SizedBox(height: 32),

                  CustomTextField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    label: 'Email',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/email.png',
                        width: 10,
                      ), // or NetworkImage
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    label: 'Password',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/padlock.png',
                        width: 10,
                      ), // or NetworkImage
                    ),
                    suffixiconvisble: Image.asset(
                      'assets/witness.png',
                      width: 10,
                    ), //
                    suffixiconNotvisble: Image.asset(
                      'assets/hide.png',
                      width: 10,
                    ), // or
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
      ),
    );
  }
}
