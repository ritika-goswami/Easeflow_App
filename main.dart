import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const EaseFlowApp());
}

class EaseFlowApp extends StatelessWidget {
  const EaseFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easeflow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Global system defaults setup matching your palette rules
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF805253),
          surface: const Color(0xFFFAF9FF),
        ),
      ),
      home: const SplashScreen(), // Pointing directly to our splash view
    );
  }
}
