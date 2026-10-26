import '../../domain/entities/alarm.dart';
import '../../domain/repositories/alarm_repository.dart';

class DemoAlarmRepository implements AlarmRepository {
  const DemoAlarmRepository();

  @override
  Future<List<Alarm>> getAlarms() async {
    return const [
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
  }
}
