import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../activity/models/activity_model.dart';
import '../../activity/repositories/activity_repository.dart';
import '../models/todo_model.dart';
import '../services/todo_storage_service.dart';

enum SystemStatus { online, offline }

enum MachineState { idle, running, error }

class HomeController extends ChangeNotifier {
  HomeController({TodoStorageService? storageService})
      : _storageService = storageService ?? TodoStorageService();

  final TodoStorageService _storageService;

  // ===== System state =====
  SystemStatus _systemStatus = SystemStatus.online;
  MachineState _machineState = MachineState.idle;
  final String _operatorName = 'Operator Station 1';

  SystemStatus get systemStatus => _systemStatus;
  MachineState get machineState => _machineState;
  String get operatorName => _operatorName;

  // ===== Time tracking =====
  DateTime _now = DateTime.now();
  late final DateTime _sessionStart;
  Timer? _ticker;

  DateTime get now => _now;
  Duration get sessionUptime => _now.difference(_sessionStart);

  // ===== Todos =====
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => List.unmodifiable(_todos);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _sessionStart = DateTime.now();
    _now = _sessionStart;
    _startTicker();
    await _loadTodos();
    _isLoading = false;
    notifyListeners();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _now = DateTime.now();
      notifyListeners();
    });
  }

  Future<void> _loadTodos() async {
    _todos = await _storageService.loadTodos();
  }

  Future<void> addTodo(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: trimmed,
      createdAt: DateTime.now(),
    );
    _todos = [..._todos, todo];
    await _storageService.saveTodos(_todos);

    await ActivityRepository.instance.log(
      type: ActivityType.todoAdded,
      title: 'Tugas baru ditambahkan',
      description: trimmed,
    );

    notifyListeners();
  }

  Future<void> toggleTodo(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final newCompleted = !todo.completed;
    _todos = _todos
        .map((t) => t.id == id ? t.copyWith(completed: newCompleted) : t)
        .toList();
    await _storageService.saveTodos(_todos);

    await ActivityRepository.instance.log(
      type: newCompleted
          ? ActivityType.todoCompleted
          : ActivityType.todoUncompleted,
      title: newCompleted ? 'Tugas diselesaikan' : 'Tugas dibuka kembali',
      description: todo.title,
    );

    notifyListeners();
  }

  Future<void> removeTodo(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    _todos = _todos.where((t) => t.id != id).toList();
    await _storageService.saveTodos(_todos);

    await ActivityRepository.instance.log(
      type: ActivityType.todoRemoved,
      title: 'Tugas dihapus',
      description: todo.title,
    );

    notifyListeners();
  }

  String machineStateLabel() {
    switch (_machineState) {
      case MachineState.idle:
        return 'IDLE';
      case MachineState.running:
        return 'RUNNING';
      case MachineState.error:
        return 'ERROR';
    }
  }

  void setMachineState(MachineState state) {
    if (_machineState == state) return;
    _machineState = state;
    notifyListeners();
  }

  void setSystemStatus(SystemStatus status) {
    if (_systemStatus == status) return;
    _systemStatus = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}