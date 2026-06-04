import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/storage_keys.dart';
import '../models/activity_model.dart';

class ActivityStorageService {
  Future<List<ActivityModel>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(StorageKeys.activities);
    if (raw == null || raw.isEmpty) return [];
    try {
      return ActivityModel.decodeList(raw);
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<ActivityModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        StorageKeys.activities, ActivityModel.encodeList(items));
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.activities);
  }
}