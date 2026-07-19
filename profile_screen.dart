import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'calendar_screen.dart';
import 'chatbot_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currentTab = 3; // Fixed highlight to Profile tab index context

  // Frontend Interaction tracking states for toggles and options
  bool _pushNotifications = true;
  bool _darkMode = false;
  String _selectedCondition = 'Select';

  final List<String> _conditions = [
    'Select',
    'PCOS (Polycystic Ovary Syndrome)',
    'PCOD (Polycystic Ovarian Disease)',
    'Thyroid Disorder (Hypothyroidism / Hyperthyroidism)',
    'Endometriosis / Adenomyosis',
    'Pregnancy / Postpartum Recovery',
    'Perimenopause / Menopause',
    'PMDD (Premenstrual Dysphoric Disorder)',
    'None / None of the above'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF), // Surface Blush matching codebase
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header Section matching codebase structure
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFF6DDDA),
                    child: const Icon(Icons.person_rounded, color: Color(0xFF805253), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'EaseFlow',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1B20),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'PROFILE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF805253),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. High Fidelity Profile Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF805253).withOpacity(0.04),
                            blurRadius: 24.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: const Color(0xFFF6DDDA),
                            child: const Icon(Icons.person_rounded, color: Color(0xFF805253), size: 46),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ritika Goswami',
                            style: GoogleFonts.literata(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1B20),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '+91 98765 43210',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6C5A58),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => debugPrint('Edit Profile tapped'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAF9FF),
                                borderRadius: BorderRadius.circular(9999),
                                border: Border.all(color: const Color(0xFFE2E2E8)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.edit_rounded, color: Color(0xFF805253), size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Edit Profile',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF805253),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. My Health Data Section Title
                    Text(
                      'My Health Data',
                      style: GoogleFonts.literata(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1B20),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // RECTIFIED: 2x2 Grid Layout Canvas matching visual requirements perfectly
                    Row(
                      children: [
                        Expanded(child: _buildHealthField(label: 'Age', value: '25', unit: 'years', icon: Icons.cake_rounded)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildHealthField(label: 'Period Length', value: '5', unit: 'days', icon: Icons.water_drop_rounded)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildHealthField(label: 'Weight', value: '58', unit: 'kg', icon: Icons.monitor_weight_rounded)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildHealthField(label: 'Height', value: '164', unit: 'cm', icon: Icons.straighten_rounded)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Dropdown health field for special conditions spanning entire width
                    _buildDropdownField(
                      label: 'Special Health Condition',
                      value: _selectedCondition,
                      items: _conditions,
                      icon: Icons.healing_rounded,
                      onChanged: (val) => setState(() => _selectedCondition = val!),
                    ),
                    const SizedBox(height: 28),

                    // 4. Settings Section Title
                    Text(
                      'Settings',
                      style: GoogleFonts.literata(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1B20),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Settings Operations Card Options Container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF805253).withOpacity(0.04),
                            blurRadius: 24.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildToggleRow(
                            title: 'Push Notifications',
                            icon: Icons.notifications_active_rounded,
                            value: _pushNotifications,
                            onChanged: (val) => setState(() => _pushNotifications = val),
                          ),
                          const Divider(color: Color(0xFFEEEDF3), height: 1),
                          _buildToggleRow(
                            title: 'Dark Mode',
                            icon: Icons.dark_mode_rounded,
                            value: _darkMode,
                            onChanged: (val) => setState(() => _darkMode = val),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 5. Outlined Rounded Logout Button Action
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton.icon(
                        onPressed: () => debugPrint('Log Out pressed'),
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        label: Text(
                          'Log Out',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFBA1A1A), // System Alert Red
                          side: const BorderSide(color: Color(0xFFFFDAD6), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // 6. Clean Bottom Navigation Bar UI Block
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
                  } else if (index == 2) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const ChatbotScreen()),
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
                  BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'AI Chatbot'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pure Helper Widget builder components matching styling context rules
  Widget _buildHealthField({required String label, required String value, required String unit, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEDF3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF805253), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF9295AB)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      value,
                      style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1A1B20)),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        unit,
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF6C5A58)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEDF3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF805253), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: value,
              dropdownColor: Colors.white,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF805253), size: 22),
              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF1A1B20)),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF9295AB)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
              ),
              items: items.map((val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(
                    val,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({required String title, required IconData icon, required bool value, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF805253), size: 22),
          const SizedBox(width: 14),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF1A1B20)),
          ),
          const Spacer(),
          Switch.adaptive(
            value: value,
            activeColor: const Color(0xFF805253),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
