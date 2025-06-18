import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}
