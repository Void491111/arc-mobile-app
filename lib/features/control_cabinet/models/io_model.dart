// lib/features/control_cabinet/models/io_model.dart

class IOModel {
  String label;
  bool isOn;

  IOModel({
    required this.label,
    this.isOn = false,
  });
}