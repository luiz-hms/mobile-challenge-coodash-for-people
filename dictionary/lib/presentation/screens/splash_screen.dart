import 'package:dictionary/core/routes/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(NamedRoute.login, (Route route) => false);
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Lottie.asset(
              'assets/translatelottie.json',
              width: 150,
              height: 150,
            ),

            Text(
              "dictionary".toUpperCase(),
              style: TextStyle(color: Color(0xfff56e0f)),
            ),
          ],
        ),
      ),
    );
  }
}
