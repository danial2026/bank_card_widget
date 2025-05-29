import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Card Widget Example',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const HomePage(),
    );
  }
}
