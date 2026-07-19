import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class OnboardingDetailsScreen extends StatefulWidget {
  const OnboardingDetailsScreen({super.key});

  @override
  State<OnboardingDetailsScreen> createState() => _OnboardingDetailsScreenState();
}

class _OnboardingDetailsScreenState extends State<OnboardingDetailsScreen> {
  final _dobController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _selectedCondition = 'Select';
  
  // Logic 1: Default period duration initialized to 5 days
  int _periodDuration = 5; 

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
  void dispose() {
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Logic 2: Date Picker restricted strictly between 14 and 45 years of age
  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime dynamicLastDate = DateTime(today.year - 14, today.month, today.day);
    final DateTime dynamicFirstDate = DateTime(today.year - 45, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dynamicLastDate, 
      firstDate: dynamicFirstDate,
      lastDate: dynamicLastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF805253),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1A1B20),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  // Logic 3 & 4: Custom Inline Validation Checks for Form Metrics Validation Loop
  void _handleSubmit() {
    final int? height = int.tryParse(_heightController.text);
    final int? weight = int.tryParse(_weightController.text);

    if (_dobController.text.isEmpty) {
      _showValidationError("Please select your Date of Birth.");
      return;
    }
    if (height == null || height < 140 || height > 190) {
      _showValidationError("Height must be a numeric value between 140 cm and 190 cm.");
      return;
    }
    if (weight == null || weight < 45 || weight > 95) {
      _showValidationError("Weight must be a numeric value between 45 kg and 95 kg.");
      return;
    }

    _handleNavigation("Complete Profile - Validated");
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)),
        backgroundColor: const Color(0xFFBA1A1A),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // FIXED Navigation Pipeline routing cleanly to HomeScreen
  void _handleNavigation(String action) {
    debugPrint("Navigation clicked: $action");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF), // Surface Blush
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Screen Title Header & Skip Action Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User Health Data',
                    style: GoogleFonts.literata(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1B20),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _handleNavigation("Skip for now"),
                    child: Text(
                      'Skip for now',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF805253),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 2. Primary Scrollable Canvas Body Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    
                    // Main Form Field Card Layout Container
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // A. Date of Birth Picker Widget
                          _buildFieldLabel('Date of Birth'),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _dobController,
                                decoration: _buildFieldInputDecoration(
                                  hint: 'dd-mm-yyyy',
                                  icon: Icons.calendar_today_rounded,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // B. Height & Weight Numeric Fields
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Height (cm)'),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      decoration: _buildFieldInputDecoration(hint: 'e.g. 165'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Weight (kg)'),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: _weightController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      decoration: _buildFieldInputDecoration(hint: 'e.g. 62'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // C. Special Health Conditions Exact Custom Dropdown Layout
                          _buildFieldLabel('Special Health Conditions'),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedCondition,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6C5A58)),
                            decoration: _buildFieldInputDecoration(hint: ''),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: const Color(0xFF1A1B20)),
                            items: _conditions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() => _selectedCondition = newValue);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. Average Period Duration Display Card
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Average Period Duration'),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_periodDuration > 1) {
                                    setState(() => _periodDuration--);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFFFAF9FF), shape: BoxShape.circle),
                                  child: const Icon(Icons.remove_rounded, color: Color(0xFF805253), size: 24),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '$_periodDuration',
                                    style: GoogleFonts.literata(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF805253),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'days',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF544242),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  if (_periodDuration < 8) {
                                    setState(() => _periodDuration++);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFFFAF9FF), shape: BoxShape.circle),
                                  child: const Icon(Icons.add_rounded, color: Color(0xFF805253), size: 24),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Based on your cycle history data window parameters.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: const Color(0xFF544242).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 4. Privacy First Security Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6DDDA),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(Icons.verified_user_rounded, color: Color(0xFF805253), size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Privacy First',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF321113),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Your data is encrypted and only used to improve your personalized therapy sessions. We never share your health journey with third parties.',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    height: 1.4,
                                    color: const Color(0xFF544341),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            
            // 5. Fixed Bottom Layout Navigation Bar Control Dock
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFEEEDF3), width: 1)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFDAC1C0)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: Text(
                        'Back',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF544242),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF805253),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                        ),
                        child: Text(
                          'Complete Profile',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1B20),
      ),
    );
  }

  InputDecoration _buildFieldInputDecoration({required String hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF9295AB), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFFAF9FF),
      prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF805253), size: 20) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E2E8), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E2E8), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF805253), width: 1.5),
      ),
    );
  }
}
