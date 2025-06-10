import 'package:doodle/core/const/colors.dart';
import 'package:doodle/core/di/injection.dart';
import 'package:doodle/core/view_model/login/login_cubit.dart';
import 'package:doodle/core/view_model/register/register_cubit.dart';
import 'package:doodle/core/view_model/splash/splash_cubit.dart';
import 'package:doodle/core/view_model/user/user_cubit.dart';
import 'package:doodle/views/Screens/home/home_screen.dart';
import 'package:doodle/views/Screens/login/login_screen.dart';
import 'package:doodle/views/Screens/register/register_screen.dart';
import 'package:doodle/views/Screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => getIt<RegisterCubit>()),
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider<UserCubit>(create: (_) => getIt<UserCubit>()),
        BlocProvider<SplashCubit>(create: (_) => SplashCubit()..loadSplash()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.ubuntuTextTheme(),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryGreen47,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen47,
              foregroundColor: Colors.white,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryGreen47,
              side: BorderSide(
                color: AppColors.primaryGreen47,
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
//------
