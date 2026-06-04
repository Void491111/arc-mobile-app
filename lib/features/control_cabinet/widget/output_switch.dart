// lib/features/control_cabinet/widgets/output_switch.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputSwitch extends StatelessWidget {
  final String label;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const OutputSwitch({
    super.key,
    required this.label,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.8, // Dikecilin dikit biar muat 5 kolom dengan rapi
          child: Switch(
            value: isOn,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFFD32F2F),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[700]),
        ),
      ],
    );
  }
}