import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin {
  final int _currentTab = 2; // Locked to Tara AI active index context
  late AnimationController _bgOrbController;
  late AnimationController _avatarPulseController;

  @override
  void initState() {
    super.initState();
    _bgOrbController = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat(reverse: true);
    _avatarPulseController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgOrbController.dispose();
    _avatarPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF),
      body: SafeArea(
        child: Stack(
          children: [
            // Premium Ambient Backdrop Orbs
            AnimatedBuilder(
              animation: _bgOrbController,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned(
                      top: -100 + (_bgOrbController.value * 40), left: -50 + (_bgOrbController.value * 20),
                      child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFFB3B3).withOpacity(0.04))),
                    ),
                  ],
                );
              },
            ),
            
            Column(
              children: [
                // Top Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    children: [
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.96, end: 1.02).animate(CurvedAnimation(parent: _avatarPulseController, curve: Curves.easeInOut)),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF6DDDA), width: 1.5)),
                          child: const CircleAvatar(radius: 22, backgroundColor: Color(0xFFF6DDDA), child: Icon(Icons.face_retouching_natural_rounded, color: Color(0xFF805253), size: 24)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tara', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1A1B20))),
                          Text('Your EaseFlow Companion', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF6C5A58))),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFEEEDF3), height: 1),
                
                // Conversation canvas area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('How may I help you today, dear? ✨', style: GoogleFonts.literata(fontSize: 24, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text("Tell me how you're feeling today, and I'll find the best way to support you.", style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF544242))),
                        const SizedBox(height: 28),
                        
                        // User Message Bubble - FIXED ( maxWidth using BoxConstraints )
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(color: const Color(0xFF805253), borderRadius: BorderRadius.circular(20).copyWith(bottomRight: Radius.zero)),
                            child: Text("I'm experiencing severe cramps on day 2 of my flow.", style: GoogleFonts.plusJakartaSans(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tara Response Card with embedded Hardware Preset Actions
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
                              boxShadow: [BoxShadow(color: const Color(0xFF805253).withOpacity(0.03), blurRadius: 16, offset: const Offset(0, 6))],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "I understand completely, dear. Let's get you some relief right away. I highly recommend activating a gentle heat therapy option on your EaseBand tracker device.",
                                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF1A1B20), height: 1.4),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(color: const Color(0xFFFAF9FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEEEDF3), width: 1)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.spa_rounded, color: Color(0xFF805253), size: 20),
                                          const SizedBox(width: 8),
                                          Text('Heat Relief Mode', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 14, color: const Color(0xFF1A1B20))),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text('Medium Intensity • 15 Mins', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF6C5A58))),
                                      const SizedBox(height: 14),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 38,
                                        child: ElevatedButton(
                                          onPressed: () => debugPrint('Starting Heat Preset'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF805253),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                                          ),
                                          child: Text('Start Now', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(color: const Color(0xFFFAF9FF), borderRadius: BorderRadius.circular(9999), border: Border.all(color: const Color(0xFFE2E2E8), width: 1)),
                              child: Text('Tell me more about heat relief', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF805253))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Input Field Composer row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file_rounded, color: Color(0xFF9295AB)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48, padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9999), border: Border.all(color: const Color(0xFFE2E2E8))),
                          child: Align(alignment: Alignment.centerLeft, child: Text('Message Tara...', style: GoogleFonts.plusJakartaSans(color: const Color(0xFF9295AB)))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const CircleAvatar(backgroundColor: Color(0xFF805253), child: Icon(Icons.arrow_upward_rounded, color: Colors.white)),
                    ],
                  ),
                ),

                // Navigation Bar handles tab configuration natively within this screen file
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color(0x0F805253), blurRadius: 16, offset: Offset(0, -4)),
                    ],
                  ),
                  child: BottomNavigationBar(
                    currentIndex: _currentTab,
                    onTap: (index) {
                      if (index == 0) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } else if (index == 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const CalendarScreen()),
                        );
                      } else if (index == 3) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      }
                    },
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: const Color(0xFF805253),
                    unselectedItemColor: const Color(0xFF9295AB),
                    selectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 12),
                    unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 12),
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Calendar'),
                      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'AI Chatbot'),
                      BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
