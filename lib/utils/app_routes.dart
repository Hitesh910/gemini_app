import 'package:flutter/material.dart';
import 'package:gemini_app/screen/history/view/history_screen.dart';
import 'package:gemini_app/screen/home/view/home_screen.dart';
import 'package:gemini_app/screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> app_routes = {
  "/":(context) => SplashScreen(),
  "/home": (context) => HomeScreen(),
  "/history":(context) => HistoryScreen(),
};
