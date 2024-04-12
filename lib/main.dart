import 'package:breatheclean_flutter/globals/pallete.dart';
import 'package:breatheclean_flutter/screens/home_screen.dart';
import 'package:breatheclean_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/bottom_navigation_provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathe Clean',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.system, // Theme based on system setting
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
