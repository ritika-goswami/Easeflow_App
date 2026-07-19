import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'home_screen.dart'; 
import 'chatbot_screen.dart';
import 'profile_screen.dart';

class CalendarScreen extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;
  const CalendarScreen({super.key, this.onTabChanged});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final int _currentTab = 1; 
  DateTime _focusedMonth = DateTime(2024, 9); 
  DateTime _selectedDate = DateTime(2024, 9, 12); 

  final List<String> _weekLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _getFirstDayOffset(DateTime date) {
    int weekday = DateTime(date.year, date.month, 1).weekday;
    return weekday - 1; 
  }

  void _changeMonth(int step) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + step);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = _getDaysInMonth(_focusedMonth);
    final int prefixOffset = _getFirstDayOffset(_focusedMonth);
    final int totalCells = daysInMonth + prefixOffset;

    final List<Map<String, dynamic>> metricCards = [
      {'icon': Icons.calendar_today_rounded, 'title': 'Next Period', 'value': '20 Days'},
      {'icon': Icons.wb_sunny_outlined, 'title': 'Fertility', 'value': 'Low'},
      {'icon': Icons.bolt_rounded, 'title': 'Energy', 'value': 'High Energy'},
      {'icon': Icons.face_rounded, 'title': 'Mood', 'value': 'Calm'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF), 
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today is September 12',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6C5A58),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your Cycle Today',
                      style: GoogleFonts.literata(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1B20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Main Scrollable Panel Canvas
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // 3. Multi-Colored Circular Cycle Progress Ring (The Halo Card)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF805253).withOpacity(0.04),
                            blurRadius: 24.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 210,
                          height: 210,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(210, 210),
                                painter: _MultiPhaseHaloPainter(),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'DAY 8',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.05,
                                      color: const Color(0xFF9295AB),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Follicular\nPhase',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.literata(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1B20),
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAF9FF),
                                      borderRadius: BorderRadius.circular(9999),
                                      border: Border.all(color: const Color(0xFFE2E2E8), width: 1),
                                    ),
                                    child: Text(
                                      'High Energy',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
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
                    ),
                    const SizedBox(height: 20),

                    // 4. Staggered 2x2 Information Cards Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: metricCards.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.4,
                      ),
                      itemBuilder: (context, index) {
                        final card = metricCards[index];
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF805253).withOpacity(0.04),
                                blurRadius: 16.0,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(card['icon'], color: const Color(0xFF805253), size: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card['title'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF9295AB),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    card['value'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1B20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // 5. Calendar Card Container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28.0),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF1A1B20)),
                                onPressed: () => _changeMonth(-1),
                              ),
                              Text(
                                _focusedMonth.month == 9 && _focusedMonth.year == 2024
                                    ? 'September 2024'
                                    : '${_focusedMonth.year} - ${_focusedMonth.month.toString().padLeft(2, '0')}',
                                style: GoogleFonts.literata(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1A1B20),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF1A1B20)),
                                onPressed: () => _changeMonth(1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _weekLabels.map((label) {
                              return SizedBox(
                                width: 32,
                                child: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF9295AB),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: totalCells,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, cellIndex) {
                              if (cellIndex < prefixOffset) {
                                return const SizedBox.shrink();
                              }
                              final int dayNumber = cellIndex - prefixOffset + 1;
                              final DateTime currentCellDate = DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);
                              final bool isCellSelected = _selectedDate.day == dayNumber &&
                                  _selectedDate.month == _focusedMonth.month &&
                                  _selectedDate.year == _focusedMonth.year;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDate = currentCellDate;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isCellSelected ? const Color(0xFF805253) : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$dayNumber',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: isCellSelected ? FontWeight.w600 : FontWeight.w500,
                                      color: isCellSelected ? Colors.white : const Color(0xFF1A1B20),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Divider(color: Color(0xFFEEEDF3), height: 1),
                          const SizedBox(height: 16),

                          // RECTIFIED: Centered Calendar Legend Item Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF6DDDA),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.water_drop_rounded, color: Color(0xFF805253), size: 14),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Menstruation',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF544242),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 6. Log Period Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () => debugPrint('Log period selected'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF805253),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        ),
                        child: Text(
                          '+ Log Period',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Next period predicted in 20 days',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6C5A58),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // 7. Clean Bottom Navigation Bar UI Block
            // 7. Clean Bottom Navigation Bar UI Block
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
}

// RECTIFIED: Multi-Phase circular progress painter utilizing proper soft cute pastel parameters
class _MultiPhaseHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 20) / 2;
    const strokeWidth = 14.0;

    const double flowAngle = 2 * math.pi * (5 / 28);
    const double follicularAngle = 2 * math.pi * (7 / 28);
    const double ovulationAngle = 2 * math.pi * (4 / 28);
    const double lutealAngle = 2 * math.pi * (12 / 28);

    final Rect boundingArea = Rect.fromCircle(center: center, radius: radius);

    // Phase 1: Menstruation -> Cute Soft Pastel Red/Pink (#FFB3B3)
    canvas.drawArc(boundingArea, -math.pi / 2, flowAngle, false, Paint()
      ..color = const Color(0xFFFFB3B3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth);

    // Phase 2: Follicular -> Cute Soft Pastel Green (#C8E6C9)
    canvas.drawArc(boundingArea, -math.pi / 2 + flowAngle, follicularAngle, false, Paint()
      ..color = const Color(0xFFC8E6C9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth);

    // Phase 3: Ovulation -> Cute Soft Pastel Blue (#B3E5FC)
    canvas.drawArc(boundingArea, -math.pi / 2 + flowAngle + follicularAngle, ovulationAngle, false, Paint()
      ..color = const Color(0xFFB3E5FC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth);

    // Phase 4: Luteal -> Cute Soft Pastel Yellow (#FFF9C4)
    canvas.drawArc(boundingArea, -math.pi / 2 + flowAngle + follicularAngle + ovulationAngle, lutealAngle, false, Paint()
      ..color = const Color(0xFFFFF9C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth);

    // Tracking Indicator Dot positioning calculations loop mapping to active window markers
    const double targetProgressAngle = -math.pi / 2 + (2 * math.pi * (8 / 28));
    final double dotX = center.dx + radius * math.cos(targetProgressAngle);
    final double dotY = center.dy + radius * math.sin(targetProgressAngle);

    canvas.drawCircle(Offset(dotX, dotY), 7.0, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(dotX, dotY), 5.0, Paint()..color = const Color(0xFF805253));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
