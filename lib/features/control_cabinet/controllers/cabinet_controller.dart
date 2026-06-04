// lib/features/control_cabinet/controllers/cabinet_controller.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/io_model.dart';

class CabinetController extends ChangeNotifier {
  // Generate 20 Digital Inputs
  final List<IOModel> digitalInputs = [
    'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10',
    'X11', 'X12', 'X13', 'Red', 'X15', 'X16', 'X17', 'Alarm', 'Green', 'X20',
  ].map((label) => IOModel(label: label)).toList();

  // Generate 20 Digital Outputs
  final List<IOModel> digitalOutputs = [
    'Y1', 'Y2', 'Y3', 'Y4', 'Y5', 'Y6', 'Y7', 'Y8', 'Y9', 'Y10',
    'Y11', 'Y12', 'Y13', 'Y14', 'red', 'Y16', 'Y17', 'Alarm', 'green', 'Y20',
  ].map((label) => IOModel(label: label)).toList();

  // Constructor: Langsung panggil fungsi load saat Controller dibuat
  CabinetController() {
    _loadSavedData();
  }

  // --- FUNGSI LOCAL STORAGE (LOAD) ---
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load label Input
    for (int i = 0; i < digitalInputs.length; i++) {
      String? savedLabel = prefs.getString('input_label_$i');
      if (savedLabel != null) digitalInputs[i].label = savedLabel;
    }

    // Load label & status Output
    for (int i = 0; i < digitalOutputs.length; i++) {
      String? savedLabel = prefs.getString('output_label_$i');
      if (savedLabel != null) digitalOutputs[i].label = savedLabel;

      // Bonus: Simpan juga status on/off switch-nya biar gak reset
      bool? savedState = prefs.getBool('output_state_$i');
      if (savedState != null) digitalOutputs[i].isOn = savedState;
    }

    notifyListeners(); // Refresh UI setelah data beres ditarik
  }

  // --- FUNGSI RESET KE PENGATURAN PABRIK ---
  Future<void> resetToDefault() async {
    final prefs = await SharedPreferences.getInstance();

    // Data bawaan pabrik
    final defaultInputs = [
      'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10',
      'X11', 'X12', 'X13', 'Red', 'X15', 'X16', 'X17', 'Alarm', 'Green', 'X20'
    ];
    final defaultOutputs = [
      'Y1', 'Y2', 'Y3', 'Y4', 'Y5', 'Y6', 'Y7', 'Y8', 'Y9', 'Y10',
      'Y11', 'Y12', 'Y13', 'Y14', 'red', 'Y16', 'Y17', 'Alarm', 'green', 'Y20'
    ];

    // Timpa list yang aktif & hapus dari memory SharedPreferences
    for (int i = 0; i < digitalInputs.length; i++) {
      digitalInputs[i].label = defaultInputs[i];
      await prefs.remove('input_label_$i');
    }

    for (int i = 0; i < digitalOutputs.length; i++) {
      digitalOutputs[i].label = defaultOutputs[i];
      await prefs.remove('output_label_$i');
    }

    notifyListeners(); // Refresh UI seketika
  }

  // --- FUNGSI UPDATE & SAVE ---
  void toggleOutput(int index, bool value) async {
    digitalOutputs[index].isOn = value;
    notifyListeners();

    // Simpan status toggle ke local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('output_state_$index', value);

    // Nanti logika fetch/kirim API Dummy ditaruh di sini
  }

  void updateInputLabel(int index, String newLabel) async {
    if (newLabel.isNotEmpty) {
      digitalInputs[index].label = newLabel;
      notifyListeners();

      // Simpan label baru ke local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('input_label_$index', newLabel);
    }
  }

  void updateOutputLabel(int index, String newLabel) async {
    if (newLabel.isNotEmpty) {
      digitalOutputs[index].label = newLabel;
      notifyListeners();

      // Simpan label baru ke local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('output_label_$index', newLabel);
    }
  }

  void updateInput(int index, bool value) {
    digitalInputs[index].isOn = value;
    notifyListeners();
  }
}