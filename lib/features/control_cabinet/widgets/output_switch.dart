// lib/features/control_cabinet/widgets/output_switch.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputSwitch extends StatelessWidget {
  final String label;
  final bool isOn;
  final ValueChanged<bool> onChanged;
  final VoidCallback onEdit; // <-- INI TAMBAHANNYA BOSS

  const OutputSwitch({
    super.key,
    required this.label,
    required this.isOn,
    required this.onChanged,
    required this.onEdit, // <-- JANGAN LUPA DI SINI JUGA
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.8,
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
        GestureDetector(
          onTap: onEdit, // <-- DAN DI SINI BUAT KLIKNYA
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