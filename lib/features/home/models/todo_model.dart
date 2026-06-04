import 'dart:convert';

class TodoModel {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    this.completed = false,
    required this.createdAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'] as String,
        title: json['title'] as String,
        completed: json['completed'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  static String encodeList(List<TodoModel> todos) =>
      jsonEncode(todos.map((t) => t.toJson()).toList());

  static List<TodoModel> decodeList(String source) {
    final List<dynamic> data = jsonDecode(source) as List<dynamic>;
    return data
        .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}