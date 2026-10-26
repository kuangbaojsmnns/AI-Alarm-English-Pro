import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/alarm.dart';
import '../../domain/repositories/alarm_repository.dart';
import '../models/alarm_dto.dart';

class SharedPreferencesAlarmRepository implements AlarmRepository {
  const SharedPreferencesAlarmRepository(this._preferences);

  static const String _storageKey = 'ai_alarm_english_pro.alarms.v1';

  final SharedPreferencesAsync _preferences;

  @override
  Future<List<Alarm>> getAlarms() async {
    final storedValue = await _preferences.getString(_storageKey);
    if (storedValue == null) {
      const initialAlarms = [
        Alarm(
          id: 'weekday',
          hour: 7,
          minute: 0,
          schedule: 'Weekdays',
          sound: 'Gentle piano',
          isEnabled: true,
        ),
        Alarm(
          id: 'weekend',
          hour: 8,
          minute: 30,
          schedule: 'Saturday, Sunday',
          sound: 'Gentle piano',
          isEnabled: false,
        ),
      ];
      await saveAlarms(initialAlarms);
      return initialAlarms;
    }

    final decoded = jsonDecode(storedValue);
    if (decoded is! List<dynamic>) {
      throw const FormatException('Stored alarms must be a JSON list.');
    }

    return decoded.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Stored alarm must be a JSON object.');
      }
      return AlarmDto.fromJson(item).toDomain();
    }).toList(growable: false);
  }

  @override
  Future<void> saveAlarms(List<Alarm> alarms) {
    final data =
        alarms.map(AlarmDto.fromDomain).map((alarm) => alarm.toJson()).toList();
    return _preferences.setString(_storageKey, jsonEncode(data));
  }
}
