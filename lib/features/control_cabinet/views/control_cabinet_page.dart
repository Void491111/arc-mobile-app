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

  Future<void> _showResetConfirmation(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Reset Pengaturan?', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        content: Text(
          'Semua nama label Input dan Output akan dikembalikan ke pengaturan pabrik (X1, Y1, dst). Lanjutkan?', 
          style: GoogleFonts.poppins(fontSize: 14)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal', style: GoogleFonts.poppins(color: Colors.grey[600], fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text('Reset', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    // Kalau user pilih 'Reset'
    if (confirm == true) {
      await _controller.resetToDefault();
      
      // Kasih toastification biar tau kalau udah sukses
      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.info,
          style: ToastificationStyle.flat,
          title: Text('Sistem Di-reset', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          description: Text('Semua label kembali ke pengaturan pabrik.', style: GoogleFonts.poppins(fontSize: 12)),
          autoCloseDuration: const Duration(seconds: 3),
          icon: const Icon(Icons.restore),
          primaryColor: const Color(0xFFD32F2F),
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
        );
      }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFFD32F2F)),
            tooltip: 'Reset ke pengaturan semula',
            onPressed: () => _showResetConfirmation(context),
          ),
          const SizedBox(width: 8),
        ],
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