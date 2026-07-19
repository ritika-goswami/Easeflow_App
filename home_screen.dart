import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_screen.dart';
import 'chatbot_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;
  const HomeScreen({super.key, this.onTabChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _viewToggle = 'Front'; // Active view: 'Front' or 'Back'
  final int _currentTab = 0; // Fixed highlight to Home index context
  
  // Local dropdown configuration tracking states initializing to 'Select'
  String _heatDurationSelection = 'Select';
  String _vibrationPatternSelection = 'Select';
  
  // Local selector button tracking states (Defaulting strictly to OFF)
  String _heatIntensity = 'OFF';
  String _vibrationIntensity = 'OFF';

  final List<String> _heatDurations = ['Select', '5 min', '10 min', '15 min', 'Continuous'];
  final List<String> _vibrationPatterns = ['Select', 'Wave', 'Pulse', 'Circular'];

  // Dynamic placeholders structured to be easily replaced by Bluetooth/Backend data later
  final String _userProfileImagePlaceholder = ''; // Path string for future network images
  final bool _isDeviceConnected = true; 
  final int _batteryPercentage = 100;

  // Logic 4: Refresh button implementation that simulates synchronization and UI rebuild
  void _handleDeviceRefresh() {
    debugPrint("Triggering synchronization scan with EaseBand hardware...");
    setState(() {
      // Rebuilds the current UI state locally to reflect live frontend synchronizations
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Device synchronized successfully',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        backgroundColor: const Color(0xFF805253),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF), // Surface Blush
      body: SafeArea(
        child: Column(
          children: [
            // REDESIGNED: Top Header Section matching the reference image exactly
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  // 1. User Profile Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFF6DDDA), // secondary-fixed
                    backgroundImage: _userProfileImagePlaceholder.isNotEmpty 
                        ? NetworkImage(_userProfileImagePlaceholder) 
                        : null,
                    child: _userProfileImagePlaceholder.isEmpty 
                        ? const Icon(Icons.person_rounded, color: Color(0xFF805253), size: 22)
                        : null,
                  ),
                  const SizedBox(width: 12),

                  // 2. Connection Status indicator row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _isDeviceConnected ? const Color(0xFF4CAF50) : const Color(0xFFBA1A1A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isDeviceConnected ? 'Connected' : 'Disconnected',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1B20),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // 3. Battery Status Metric indicator
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.battery_full_rounded, color: Color(0xFF805253), size: 22),
                      const SizedBox(width: 4),
                      Text(
                        '$_batteryPercentage%',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1B20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // 4. Working Refresh Action Button Component
                  GestureDetector(
                    onTap: _handleDeviceRefresh,
                    child: const Icon(
                      Icons.refresh_rounded, 
                      color: Color(0xFF1A1B20), 
                      size: 22,
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
                  children: [
                    // Large Product Image Asset Area (Hidden in Back View)
                    if (_viewToggle == 'Front') ...[
                      Container(
                        width: double.infinity,
                        height: 240,
                        margin: const EdgeInsets.only(bottom: 24.0),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'assets/images/easeband.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.broken_image_rounded, size: 48, color: Color(0xFF805253)),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Loading easeband.png asset...',
                                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],

                    // Front / Back View Switch Segmented Controller
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEDF3),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        children: ['Front', 'Back'].map((view) {
                          final isSelected = _viewToggle == view;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _viewToggle = view),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9999),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          )
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  view,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? const Color(0xFF1A1B20) : const Color(0xFF6C5A58),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Heat Therapy Card Settings Panel (Applied identically to Front and Back views)
                    _buildTherapyCard(
                      title: 'Heat Therapy Settings',
                      icon: Icons.spa_rounded, 
                      currentIntensity: _heatIntensity,
                      onIntensityChanged: (val) => setState(() => _heatIntensity = val),
                      dropdownWidget: _buildDropdownLabelColumn(
                        label: 'Duration',
                        value: _heatDurationSelection,
                        items: _heatDurations,
                        onChanged: (val) => setState(() => _heatDurationSelection = val!),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Vibration Therapy Card Settings Panel (Completely hidden in Back View)
                    if (_viewToggle == 'Front') ...[
                      _buildTherapyCard(
                        title: 'Vibration Therapy Settings',
                        icon: Icons.vibration_rounded,
                        currentIntensity: _vibrationIntensity,
                        onIntensityChanged: (val) => setState(() => _vibrationIntensity = val),
                        dropdownWidget: _buildDropdownLabelColumn(
                          label: 'Pattern',
                          value: _vibrationPatternSelection,
                          items: _vibrationPatterns,
                          onChanged: (val) => setState(() => _vibrationPatternSelection = val!),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),

            // Responsive Bottom Navigation Bar UI
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0F805253),
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentTab,
                onTap: (index) {
                  if (index == 1) {
                    // Navigate cleanly to standalone Calendar view layout page
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CalendarScreen()),
                    );
                  } else if (index == 2) {
                    // Navigate cleanly to standalone Chatbot view layout page
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ChatbotScreen()),
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_rounded),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline_rounded),
                    label: 'AI Chatbot',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTherapyCard({
    required String title,
    required IconData icon,
    required String currentIntensity,
    required ValueChanged<String> onIntensityChanged,
    required Widget dropdownWidget,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF805253), size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1B20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Text(
            'Intensity',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6C5A58),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: ['OFF', 'L', 'M', 'H'].map((level) {
              final isSelected = currentIntensity == level;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onIntensityChanged(level),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF805253) : const Color(0xFFFAF9FF),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : const Color(0xFFE2E2E8),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      level,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF544242),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          dropdownWidget,
        ],
      ),
    );
  }

  Widget _buildDropdownLabelColumn({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6C5A58),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          dropdownColor: Colors.white,
          isExpanded: true,
          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF1A1B20)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFAF9FF),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E2E8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E2E8)),
            ),
          ),
          items: items.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
