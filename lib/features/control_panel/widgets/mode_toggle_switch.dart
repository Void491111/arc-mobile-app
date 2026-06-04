import 'package:flutter/material.dart';

class ModeToggleSwitch extends StatelessWidget {
  final bool isJointMode;
  final VoidCallback onToggle;

  const ModeToggleSwitch({super.key, required this.isJointMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(child: _buildBtn('JOINT (J1/J2)', isJointMode)),
          Expanded(child: _buildBtn('WORLD (X/Y)', !isJointMode)),
        ],
      ),
    );
  }

  Widget _buildBtn(String text, bool isSelected) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.red.shade700 : Colors.grey.shade500,
            fontWeight: FontWeight.bold, fontSize: 13,
          ),
        ),
      ),
    );
  }
}