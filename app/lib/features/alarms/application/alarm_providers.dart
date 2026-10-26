import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/demo_alarm_repository.dart';
import '../domain/entities/alarm.dart';
import '../domain/repositories/alarm_repository.dart';

final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  return const DemoAlarmRepository();
});

final alarmsProvider = FutureProvider<List<Alarm>>((ref) {
  return ref.watch(alarmRepositoryProvider).getAlarms();
});
