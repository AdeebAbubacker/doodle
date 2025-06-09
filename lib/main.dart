import 'package:doodle/core/di/injection.dart';
import 'package:doodle/core/services/api_service.dart';
import 'package:doodle/core/view_model/login/login_cubit.dart';
import 'package:doodle/core/view_model/register/register_cubit.dart';
import 'package:doodle/core/view_model/splash/splash_cubit.dart';
import 'package:doodle/core/view_model/user/user_cubit.dart';
import 'package:doodle/views/Screens/home/home_screen.dart';
import 'package:doodle/views/Screens/login/login_screen.dart';
import 'package:doodle/views/Screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit(apiService)),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit(apiService)),
        BlocProvider<UserCubit>(create: (_) => UserCubit(apiService)),
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()..loadSplash()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MVVM Bloc Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.ubuntuTextTheme(), // apply Ubuntu globally
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
//------