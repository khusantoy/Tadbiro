import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return const HomeScreen();
    //       }
    //       return const LoginScreen();
    //     },
    //   ),
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/images/calendar.svg",
          width: 100,
        ),
      ),
    );
  }
}
