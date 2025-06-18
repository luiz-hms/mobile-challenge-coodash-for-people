import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/core/routes/route.dart';
import 'package:dictionary/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
      routes: RouteHandler.routes,
      initialRoute: NamedRoute.splash,
    );
  }
}
