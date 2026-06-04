// lib/features/control_cabinet/widgets/input_indicator.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputIndicator extends StatelessWidget {
  final String label;
  final bool isOn;
  final VoidCallback onEdit;

  const InputIndicator({
    super.key, 
    required this.label, 
    required this.isOn,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center, // Biar pas di tengah cell Grid
      children: [
        Container(
          width: 16,  // <-- Kecilin ke 16 biar makin manis boss
          height: 16, // <-- Kecilin ke 16
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOn ? const Color(0xFFD32F2F) : Colors.grey[300],
            border: Border.all(color: Colors.grey[400]!, width: 0.5),
          ),
        ),
        const SizedBox(height: 4), // Rapatkan jarak ke teks
        GestureDetector(
          onTap: onEdit,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10, 
              color: const Color(0xFFD32F2F),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}