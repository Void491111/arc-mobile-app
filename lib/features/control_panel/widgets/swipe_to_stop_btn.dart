import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SwipeToStopBtn extends StatelessWidget {
  final Future<void> Function() onStop;

  const SwipeToStopBtn({super.key, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      borderRadius: 30,
      elevation: 0,
      innerColor: Colors.red.shade600,
      outerColor: Colors.red.shade50,
      sliderButtonIcon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      text: '>> SWIPE TO EMERGENCY STOP',
      textStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w800, letterSpacing: 1),
      onSubmit: onStop, // Fungsi kalau mentok digeser
    );
  }
}