import 'package:doodle/core/const/text_styles.dart';
import 'package:doodle/core/view_model/register/register_cubit.dart';
import 'package:doodle/views/widget/custom_button.dart';
import 'package:doodle/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterForm();
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<RegisterCubit>().regsiter(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: BlocConsumer<RegisterCubit, RegsiterState>(
              listener: (context, state) {
                if (state == RegsiterState.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')),
                  );
                  Navigator.pop(context);
                } else if (state == RegsiterState.userNotinDb) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User Not in DB')),
                  );
                } else if (state == RegsiterState.noInternet) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No Internt')),
                  );
                } else if (state == RegsiterState.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registration failed. Please try again.'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
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

                    const SizedBox(height: 8),

                    // Title
                    Text(
                      'Create Account',
                      style: AppTextStyles.blackW700S26,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in your details to register',
                      style: AppTextStyles.blackW500S16,
                    ),
                    const SizedBox(height: 32),

                    CustomTextField(
                      controller: _emailController,
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
                      controller: _passwordController,
                      focusNode: passwordFocusNode,
                      label: 'Password',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/padlock.png',
                          width: 10,
                        ),
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

                    CustomButton(
                      onPressed: _register,
                      label: 'Register',
                      isLoading: state == RegsiterState.loading,
                    ),
                    const SizedBox(height: 20),

                    // Already have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Back to login
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
