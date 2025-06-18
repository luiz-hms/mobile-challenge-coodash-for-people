import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/my_app.dart';
import 'package:dictionary/services/user_session.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await locator<UserSession>().load;
  runApp(const MyApp());
}
