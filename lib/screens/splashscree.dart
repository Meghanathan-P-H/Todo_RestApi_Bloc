import 'package:flutter/material.dart';
import 'package:to_do_app/screens/homescreen.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ScreenHome()));
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/to-do-list.png',
          width: 280,
          height: 280,
        ),
      ),
    );
  }
}
