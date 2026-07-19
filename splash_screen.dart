import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Your Custom App Logo (Displays your actual image file)
              Image.asset(
                'assets/images/logo.PNG',
                width: 140,
                height: 140,
                fit: BoxFit.contain, // FIX: Changed from Alignment to BoxFit
                // Graceful fallback loading helper if the asset file isn't found
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF805253).withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey),
                  );
                },
              ),
              const SizedBox(height: 32), // Layout stack spacing (stack-lg)
              
              // 2. Main App Branding Text (Literata Headline Typography)
              Text(
                'Easeflow',
                style: GoogleFonts.literata(
                  textStyle: const TextStyle(
                    fontFamily: 'serif', 
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1B20),
                    letterSpacing: -0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
