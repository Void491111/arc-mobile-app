import 'dart:convert';

enum ActivityType {
  todoAdded,
  todoCompleted,
  todoUncompleted,
  todoRemoved,
  machineStateChanged,
  systemEvent;

  String get label {
    switch (this) {
      case ActivityType.todoAdded:
        return 'Tugas Ditambah';
      case ActivityType.todoCompleted:
        return 'Tugas Selesai';
      case ActivityType.todoUncompleted:
        return 'Tugas Dibuka';
      case ActivityType.todoRemoved:
        return 'Tugas Dihapus';
      case ActivityType.machineStateChanged:
        return 'Status Mesin';
      case ActivityType.systemEvent:
        return 'Sistem';
    }
  }
}

class ActivityModel {
  final String id;
  final ActivityType type;
  final String title;
  final String? description;
  final DateTime timestamp;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'title': title,
        'description': description,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'] as String,
        type: ActivityType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => ActivityType.systemEvent,
        ),
        title: json['title'] as String,
        description: json['description'] as String?,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  static String encodeList(List<ActivityModel> items) =>
      jsonEncode(items.map((e) => e.toJson()).toList());

  static List<ActivityModel> decodeList(String source) {
    final data = jsonDecode(source) as List<dynamic>;
    return data
        .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}