import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_details_screen.dart'; // Added the import to connect to our new screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF), // Surface Blush
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              
              // Welcome Header Section
              Text(
                "Let's Get Started",
                style: GoogleFonts.literata(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1B20),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue your wellness journey',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF544242).withOpacity(0.7),
                ),
              ),
              
              const SizedBox(height: 48),

              // Full Name Input Field
              Text(
                'Full Name',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1B20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _fullNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'John Doe',
                  hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF9295AB)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFDAC1C0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFE2E2E8), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFF805253), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Mobile Number Input Field
              Text(
                'Mobile Number',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1B20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+1 (555) 000-0000',
                  hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF9295AB)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFDAC1C0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFE2E2E8), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFF805253), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Password Input Field
              Text(
                'Password',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1B20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF9295AB)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        color: const Color(0xFF6C5A58),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFDAC1C0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFFE2E2E8), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: const BorderSide(color: Color(0xFF805253), width: 1.5),
                  ),
                ),
              ),

              // Forgot Password Action Row
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => debugPrint('Forgot Password pressed'),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF805253),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Primary Pill Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Triggers the animation transition to your Onboarding Details View
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OnboardingDetailsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF805253),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign Up Gateway Switch Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF544242),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('Go to Sign Up'),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF805253),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
