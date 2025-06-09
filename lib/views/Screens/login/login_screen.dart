// import 'package:doodle/core/di/injection.dart';
// import 'package:doodle/core/services/api_service.dart';
// import 'package:doodle/core/view_model/login/login_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController(
//     text: "eve.holt@reqres.in",
//   );
//   final TextEditingController passwordController = TextEditingController(
//     text: "pistol",
//   );

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: BlocListener<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state == LoginState.success) {
//             Navigator.pushReplacementNamed(context, '/home');
//           } else if (state == LoginState.failure) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text('Login Failed')));
//           }
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               BlocBuilder<LoginCubit, LoginState>(
//                 builder: (context, state) {
//                   if (state == LoginState.loading) {
//                     return CircularProgressIndicator();
//                   }
//                   return ElevatedButton(
//                     onPressed: () {
//                       context.read<LoginCubit>().login(
//                         emailController.text,
//                         passwordController.text,
//                       );
//                     },
//                     child: Text('Login'),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
    final theme = Theme.of(context);
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
                    'assets/logo.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 40),

                // Title
                Text(
                  'Welcome Back',
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                ),
                const SizedBox(height: 32),

                // Email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state == LoginState.loading
                            ? null
                            : () {
                                context.read<LoginCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state == LoginState.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Login'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Register Button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
