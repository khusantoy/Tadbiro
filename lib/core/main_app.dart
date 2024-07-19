import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:tadbiro/ui/screens/settings_screen.dart';
import 'package:tadbiro/ui/screens/splash_screen.dart';
import 'package:tadbiro/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentLang = 0;

  void changeLanguage(int langIndex) {
    setState(() {
      currentLang = langIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          // locale: AppLocalizations.supportedLocales[currentLang],
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          darkTheme: darkTheme,
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
            AppRoutes.settings: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
