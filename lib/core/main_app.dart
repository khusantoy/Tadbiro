import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadbiro/ui/screens/add_event_screen.dart';
import 'package:tadbiro/ui/screens/auth/login_screen.dart';
import 'package:tadbiro/ui/screens/auth/register_screen.dart';
import 'package:tadbiro/ui/screens/auth/reset_password_screen.dart';
import 'package:tadbiro/ui/screens/event_details_screen.dart';
import 'package:tadbiro/ui/screens/home_screen.dart';
import 'package:tadbiro/ui/screens/map_screen.dart';
import 'package:tadbiro/ui/screens/my_events_screen.dart';
import 'package:tadbiro/ui/screens/notificatioins_screen.dart';
import 'package:tadbiro/ui/screens/profile_screen.dart';
import 'package:tadbiro/ui/screens/splash_screen.dart';
import 'package:tadbiro/utils/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.register: (context) => const RegisterScreen(),
          AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
          AppRoutes.notifications: (context) => const NotificatioinsScreen(),
          AppRoutes.details: (context) => const EventDetailsScreen(),
          AppRoutes.events: (context) => const MyEventsScreen(),
          AppRoutes.addEvent: (context) => const AddEventScreen(),
          AppRoutes.map: (context) => const MapScreen(),
          AppRoutes.profile: (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
