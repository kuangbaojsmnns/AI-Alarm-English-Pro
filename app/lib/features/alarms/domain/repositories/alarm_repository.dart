import '../entities/alarm.dart';

abstract interface class AlarmRepository {
  Future<List<Alarm>> getAlarms();
}
