import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/shared_preferences_alarm_repository.dart';
import '../domain/entities/alarm.dart';
import '../domain/repositories/alarm_repository.dart';

final sharedPreferencesAsyncProvider = Provider<SharedPreferencesAsync>((ref) {
  return SharedPreferencesAsync();
});

final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  return SharedPreferencesAlarmRepository(
    ref.watch(sharedPreferencesAsyncProvider),
  );
});

final alarmsProvider = AsyncNotifierProvider<AlarmsController, List<Alarm>>(
  AlarmsController.new,
);

class AlarmsController extends AsyncNotifier<List<Alarm>> {
  @override
  Future<List<Alarm>> build() {
    return ref.watch(alarmRepositoryProvider).getAlarms();
  }

  Future<void> setEnabled(String alarmId, bool isEnabled) async {
    final current = state.asData?.value;
    if (current == null) return;

    final updated = current
        .map((alarm) => alarm.id == alarmId
            ? alarm.copyWith(isEnabled: isEnabled)
            : alarm)
        .toList(growable: false);
    await _save(updated, current);
  }

  Future<void> addAlarm(Alarm alarm) async {
    final current = state.asData?.value;
    if (current == null) return;

    await _save([...current, alarm], current);
  }

  Future<void> _save(List<Alarm> updated, List<Alarm> previous) async {
    state = AsyncData(updated);
    try {
      await ref.read(alarmRepositoryProvider).saveAlarms(updated);
    } on Object catch (error, stackTrace) {
      state = AsyncData(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
