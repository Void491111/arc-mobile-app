// lib/features/control_cabinet/widgets/edit_label_dialog.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLabelDialog extends StatefulWidget {
  final String currentLabel;
  const EditLabelDialog({super.key, required this.currentLabel});

  @override
  State<EditLabelDialog> createState() => _EditLabelDialogState();
}

class _EditLabelDialogState extends State<EditLabelDialog> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    // Isi otomatis textfield dengan nama label yang sekarang
    _textController = TextEditingController(text: widget.currentLabel);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Biar tinggi modal menyesuaikan isi
          children: [
            Text(
              'Ubah Label',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Silahkan masukkan nama label baru',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Tulis Label...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
               width: double.infinity,
               height: 48,
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF333333), // Warna tombol dark abu-abu
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
                 onPressed: () {
                   // Kembalikan teks yang diketik ke halaman utama
                   Navigator.pop(context, _textController.text);
                 },
                 child: Text(
                   'Simpan',
                   style: GoogleFonts.poppins(
                     color: Colors.white,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: GoogleFonts.poppins(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}