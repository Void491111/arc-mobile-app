// lib/features/control_cabinet/controllers/cabinet_controller.dart
import 'package:flutter/material.dart';
import '../models/io_model.dart';

class CabinetController
    extends
        ChangeNotifier {
  // Generate 20 Digital Inputs
  final List<
    IOModel
  >
  digitalInputs =
      [
            'X1',
            'X2',
            'X3',
            'X4',
            'X5',
            'X6',
            'X7',
            'X8',
            'X9',
            'X10',
            'X11',
            'X12',
            'X13',
            'Red',
            'X15',
            'X16',
            'X17',
            'Alarm',
            'Green',
            'X20',
          ]
          .map(
            (
              label,
            ) => IOModel(
              label: label,
            ),
          )
          .toList();

  // Generate 20 Digital Outputs
  final List<
    IOModel
  >
  digitalOutputs =
      [
            'Y1',
            'Y2',
            'Y3',
            'Y4',
            'Y5',
            'Y6',
            'Y7',
            'Y8',
            'Y9',
            'Y10',
            'Y11',
            'Y12',
            'Y13',
            'Y14',
            'red',
            'Y16',
            'Y17',
            'Alarm',
            'green',
            'Y20',
          ]
          .map(
            (
              label,
            ) => IOModel(
              label: label,
            ),
          )
          .toList();

  // Logic untuk mengubah status Output (karena switch bisa ditekan)
  void toggleOutput(
    int index,
    bool value,
  ) {
    digitalOutputs[index].isOn = value;
    notifyListeners();

    // Nanti logika fetch/kirim API Dummy ditaruh di sini boss!
    // Contoh: ApiService().sendMachineCommand(digitalOutputs[index].label, value);
  }

  // Logic untuk mensimulasikan input dari mesin berubah
  void updateInput(
    int index,
    bool value,
  ) {
    digitalInputs[index].isOn = value;
    notifyListeners();
  }

  void updateInputLabel(
    int index,
    String newLabel,
  ) {
    if (newLabel.isNotEmpty) {
      digitalInputs[index].label = newLabel;
      notifyListeners();
    }
  }

  void updateOuotputLabel(
    int index,
    String newLabel,
  ) {
    if (newLabel.isNotEmpty) {
      digitalOutputs[index].label = newLabel;
    }
  }
}
