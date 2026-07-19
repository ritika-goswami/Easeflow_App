import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ProfileCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0), // rounded-lg token (24px)
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF805253).withOpacity(0.04), // Soft primary tinted shadow
            blurRadius: 24.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
