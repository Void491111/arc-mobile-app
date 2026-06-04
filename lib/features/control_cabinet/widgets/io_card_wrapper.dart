// lib/features/control_cabinet/widgets/io_card_wrapper.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IOCardWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const IOCardWrapper({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 16, color: const Color(0xFFD32F2F)),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD32F2F),
                    ),
                  ),
                ],
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 24),
          child, // Ini tempat Grid-nya nanti dimasukin
        ],
      ),
    );
  }
}