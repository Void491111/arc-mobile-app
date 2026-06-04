import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JointControlPad extends StatelessWidget {
  final String title;
  final Function(StickDragDetails) onDrag;
  final VoidCallback onReset;

  const JointControlPad({
    super.key,
    required this.title,
    required this.onDrag,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        
        // --- JOYSTICK CUSTOM UI BOSS ---
        Joystick(
          mode: JoystickMode.horizontal,
          listener: onDrag,
          
          // 1. BASE: Lingkaran abu-abu muda yang ukurannya pas!
          base: Container(
            width: 90, // Ukuran dikecilin biar muat jejer dua
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
              ],
            ),
          ),
          
          // 2. STICK: Tombol merah industri andalan boss
          stick: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.red.shade700, 
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),

        // --- ORNAMEN TOMBOL < > SEPERTI DI FIGMA ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildArrowBtn(Icons.chevron_left),
            const SizedBox(width: 12),
            _buildArrowBtn(Icons.chevron_right),
          ],
        ),
        const SizedBox(height: 8),

        // --- TOMBOL RESET ---
        TextButton.icon(
          onPressed: onReset,
          icon: Icon(Icons.refresh, color: Colors.red.shade700, size: 18),
          label: Text('Reset J${title.split(' ').last}', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildArrowBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.grey.shade600),
    );
  }
}