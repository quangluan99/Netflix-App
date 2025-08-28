import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_app/presentation/screens/app_navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  void _navigateIfMounted() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AppNavbarScreen()),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset(
          'assets/netflix.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller =
                AnimationController(vsync: this, duration: composition.duration)
                  ..addStatusListener((status) {
                    if (status == AnimationStatus.completed) {
                      _navigateIfMounted();
                    }
                  })
                  ..forward();
            setState(() {});
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
