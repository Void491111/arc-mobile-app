// lib/features/control_cabinet/views/control_cabinet_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../controllers/cabinet_controller.dart';
import '../widgets/edit_label_dialog.dart';
import '../widgets/digital_input_section.dart'; // <-- Import potongan pertama
import '../widgets/digital_output_section.dart'; // <-- Import potongan kedua

class ControlCabinetPage extends StatefulWidget {
  const ControlCabinetPage({super.key});

  @override
  State<ControlCabinetPage> createState() => _ControlCabinetPageState();
}

class _ControlCabinetPageState extends State<ControlCabinetPage> {
  final CabinetController _controller = CabinetController();
  final ScrollController _outputScrollController = ScrollController();

  @override
  void dispose() {
    _outputScrollController.dispose();
    super.dispose();
  }

  Future<void> _showEditLabelDialog(
      BuildContext context, bool isInput, int index, String currentLabel) async {
    final newLabel = await showDialog<String>(
      context: context,
      builder: (context) => EditLabelDialog(currentLabel: currentLabel),
    );

    if (newLabel != null && newLabel.trim().isNotEmpty && newLabel.trim() != currentLabel) {
      final finalLabel = newLabel.trim();
      
      if (isInput) {
        _controller.updateInputLabel(index, finalLabel);
      } else {
        _controller.updateOutputLabel(index, finalLabel);
      }

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: Text('Label Diperbarui', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        description: Text('Berhasil mengubah nama menjadi "$finalLabel"', style: GoogleFonts.poppins(fontSize: 12)),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 3),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        icon: const Icon(Icons.check_circle_outline),
        primaryColor: const Color(0xFFD32F2F),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E1E1E),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: highModeShadow,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: Text(
          'Control Cabinet',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFD32F2F),
          ),
        ),
        centerTitle: false,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // Jauh lebih clean, cuma panggil widget-nya!
                DigitalInputSection(
                  controller: _controller,
                  onEditLabel: _showEditLabelDialog,
                ),
                
                const SizedBox(height: 16),
                
                DigitalOutputSection(
                  controller: _controller,
                  scrollController: _outputScrollController,
                  onEditLabel: _showEditLabelDialog,
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}