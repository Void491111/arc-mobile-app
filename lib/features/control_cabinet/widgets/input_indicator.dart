// lib/features/control_cabinet/widgets/input_indicator.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputIndicator extends StatelessWidget {
  final String label;
  final bool isOn;
  final VoidCallback onEdit; // Tambahan callback klik

  const InputIndicator({
    super.key, 
    required this.label, 
    required this.isOn,
    required this.onEdit, // Wajib diisi
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOn ? const Color(0xFFD32F2F) : Colors.grey[300],
            border: Border.all(color: Colors.grey[400]!, width: 0.5),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onEdit, // Memicu modal pop-up
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10, 
              color: const Color(0xFFD32F2F), // Warnain merah/biru biar ketahuan bisa diklik
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