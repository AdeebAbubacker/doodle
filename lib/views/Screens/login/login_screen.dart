import 'package:doodle/core/di/injection.dart';
import 'package:doodle/core/services/api_service.dart';
import 'package:doodle/core/view_model/login/login_cubit.dart';
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
    return BlocProvider(
      create: (_) => LoginCubit(getIt<ApiService>()),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state == LoginState.success) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state == LoginState.failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Login Failed')));
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state == LoginState.loading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: Text('Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
