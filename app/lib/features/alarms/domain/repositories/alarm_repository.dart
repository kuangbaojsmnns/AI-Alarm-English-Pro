import '../entities/alarm.dart';

abstract interface class AlarmRepository {
  Future<List<Alarm>> getAlarms();
  Future<void> saveAlarms(List<Alarm> alarms);
}
