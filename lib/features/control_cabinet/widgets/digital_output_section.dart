// lib/features/control_cabinet/widgets/digital_output_section.dart
import 'package:flutter/material.dart';

import '../controllers/cabinet_controller.dart';
import 'io_card_wrapper.dart';
import 'output_switch.dart';

class DigitalOutputSection extends StatelessWidget {
  final CabinetController controller;
  final ScrollController scrollController;
  final Function(BuildContext, bool, int, String) onEditLabel;

  const DigitalOutputSection({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.onEditLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IOCardWrapper(
        title: 'Digital Output',
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 4.0,
          radius: const Radius.circular(8),
          child: GridView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: controller.digitalOutputs.length,
            itemBuilder: (context, index) {
              final item = controller.digitalOutputs[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutputSwitch(
                  label: item.label,
                  isOn: item.isOn,
                  onChanged: (val) => controller.toggleOutput(index, val),
                  onEdit: () => onEditLabel(context, false, index, item.label),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}