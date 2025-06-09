import 'package:doodle/core/di/injection.dart';
import 'package:doodle/views/Screens/home/home_screen.dart';
import 'package:doodle/views/Screens/login/login_screen.dart';
import 'package:doodle/views/Screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Bloc Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
//------