import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/storage_keys.dart';
import '../models/todo_model.dart';

/// Wrapper buat shared_preferences. Controller gak perlu tau soal
/// SharedPreferences langsung — semua I/O lewat sini.
class TodoStorageService {
  Future<
    List<
      TodoModel
    >
  >
  loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(
      StorageKeys.todos,
    );
    if (raw ==
            null ||
        raw.isEmpty)
      return [];
    try {
      return TodoModel.decodeList(
        raw,
      );
    } catch (
      _
    ) {
      // Kalo data corrupt, balikin list kosong daripada crash
      return [];
    }
  }

  Future<
    void
  >
  saveTodos(
    List<
      TodoModel
    >
    todos,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      StorageKeys.todos,
      TodoModel.encodeList(
        todos,
      ),
    );
  }

  Future<
    void
  >
  clearTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
      StorageKeys.todos,
    );
  }
}
