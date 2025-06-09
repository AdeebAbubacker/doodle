import 'package:doodle/core/services/api_service.dart';
import 'package:doodle/core/view_model/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final ApiService apiService;

  const RegisterPage({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(apiService),
      child: RegisterForm(),
    );
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    context.read<RegisterCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocConsumer<RegisterCubit, RegsiterState>(
          listener: (context, state) {
            if (state == RegsiterState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration successful!')),
              );
              // Optionally navigate to another screen
            } else if (state == RegsiterState.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Registration failed. Please try again.'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state == RegsiterState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                ElevatedButton(onPressed: _register, child: Text('Register')),
              ],
            );
          },
        ),
      ),
    );
  }
}
