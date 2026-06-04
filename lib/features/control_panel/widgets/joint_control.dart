import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JointControlPad extends StatelessWidget {
  final String title;
  final Function(StickDragDetails) onDrag;
  final VoidCallback onReset;

  const JointControlPad({super.key, required this.title, required this.onDrag, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        // Joystick super instan!
        Joystick(
          mode: JoystickMode.horizontal, // Geser kiri-kanan aja sesuai J1/J2
          listener: onDrag,
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: onReset,
          icon: Icon(Icons.refresh, color: Colors.red.shade700, size: 18),
          label: Text('Reset', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}