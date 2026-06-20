// lib/features/control_panel/controllers/control_panel_controller.dart
import 'package:flutter/material.dart';

class ControlPanelController extends ChangeNotifier {
  bool isJointMode = true;
  bool isPowerOn = false;
  double speedValue = 25.0;
  
  // storage untuk nilai
  double j1Pos = 0.0;
  double j2Pos = 0.0;

  void toggleMode() {
    isJointMode = !isJointMode;
    notifyListeners();
  }

  void togglePower(bool value) {
    isPowerOn = value;
    if (!isPowerOn) {
      // balek kan nilai ke 0 kalau status nya mati
      speedValue = 0.0;
    }
    notifyListeners();
  }

  void updateSpeed(double value) {
    if (!isPowerOn) return; // Gak bisa ubah speed kalau mesin mati
    speedValue = value;
    notifyListeners();
  }

  void updateJ1(double delta) {
    if (!isPowerOn) return;
    j1Pos += delta;
    notifyListeners();
  }

  void updateJ2(double delta) {
    if (!isPowerOn) return;
    j2Pos += delta;
    notifyListeners();
  }

  void resetJ1() {
    j1Pos = 0.0;
    notifyListeners();
  }

  void resetJ2() {
    j2Pos = 0.0;
    notifyListeners();
  }

  void emergencyStop() {
    isPowerOn = false;
    speedValue = 0.0;
    notifyListeners();
  }
}
