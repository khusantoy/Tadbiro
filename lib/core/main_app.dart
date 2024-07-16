import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadbiro/ui/screens/auth/login_screen.dart';
import 'package:tadbiro/ui/screens/auth/register_screen.dart';
import 'package:tadbiro/ui/screens/auth/reset_password_screen.dart';
import 'package:tadbiro/ui/screens/home_screen.dart';
import 'package:tadbiro/utils/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const LoginScreen();
          },
        ),
        routes: {
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.register: (context) => const RegisterScreen(),
          AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
        },
      ),
    );
  }
}
