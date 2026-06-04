import 'package:flutter/material.dart';

class PositionCard extends StatelessWidget {
  final String title;
  final String value;

  const PositionCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 10, spreadRadius: 1)],
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, fontFamily: 'Courier')),
        ],
      ),
    );
  }
}