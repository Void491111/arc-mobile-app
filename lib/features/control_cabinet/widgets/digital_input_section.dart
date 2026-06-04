// lib/features/control_cabinet/widgets/digital_input_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cabinet_controller.dart';
import 'io_card_wrapper.dart';
import 'input_indicator.dart';

class DigitalInputSection extends StatelessWidget {
  final CabinetController controller;
  final Function(BuildContext, bool, int, String) onEditLabel;

  const DigitalInputSection({
    super.key,
    required this.controller,
    required this.onEditLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IOCardWrapper(
        title: 'Digital Input',
        trailing: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD32F2F), 
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text('Off', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
          ],
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.3,
          ),
          itemCount: controller.digitalInputs.length,
          itemBuilder: (context, index) {
            final item = controller.digitalInputs[index];
            return InputIndicator(
              label: item.label,
              isOn: item.isOn,
              onEdit: () => onEditLabel(context, true, index, item.label),
            );
          },
        ),
      ),
    );
  }
}