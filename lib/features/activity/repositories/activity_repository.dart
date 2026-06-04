import 'package:flutter/foundation.dart';

import '../models/activity_model.dart';
import '../services/activity_storage_service.dart';

/// Repository singleton untuk activity log. Cross-feature.
/// Akses: `ActivityRepository.instance.log(...)`
class ActivityRepository extends ChangeNotifier {
  ActivityRepository._({ActivityStorageService? service})
      : _service = service ?? ActivityStorageService();

  static ActivityRepository? _instance;

  static ActivityRepository get instance {
    _instance ??= ActivityRepository._();
    return _instance!;
  }

  final ActivityStorageService _service;
  List<ActivityModel> _items = [];

  /// Semua activity, sorted newest first
  List<ActivityModel> get all {
    final sorted = [..._items]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return List.unmodifiable(sorted);
  }

  /// N activity terbaru
  List<ActivityModel> recent(int n) {
    final sorted = all;
    return sorted.length > n ? sorted.sublist(0, n) : sorted;
  }

  int get count => _items.length;
  bool get hasMoreThan3 => _items.length > 3;

  /// Panggil sekali di main.dart sebelum runApp
  Future<void> init() async {
    _items = await _service.load();
    notifyListeners();
  }

  /// Catat aktivitas baru. Dipanggil dari controller manapun.
  Future<void> log({
    required ActivityType type,
    required String title,
    String? description,
  }) async {
    final activity = ActivityModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      title: title,
      description: description,
      timestamp: DateTime.now(),
    );
    _items = [..._items, activity];
    await _service.save(_items);
    notifyListeners();
  }

  Future<void> clear() async {
    _items = [];
    await _service.save(_items);
    notifyListeners();
  }

  @visibleForTesting
  static void resetForTest() => _instance = null;
}