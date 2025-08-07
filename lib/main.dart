import 'package:flutter/material.dart';
import 'package:netflix_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(NetflixApp());
}

class NetflixApp extends StatelessWidget {
  const NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      // dark theme
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      home: SplashScreen(),
    );
  }
}
