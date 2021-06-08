import 'package:flutter/material.dart';
import 'package:modul6/splashscreen_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    theme: ThemeData.light(),
    home: SplashScreenPage(),
  ));
}