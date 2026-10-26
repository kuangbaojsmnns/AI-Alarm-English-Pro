import '../../domain/entities/alarm.dart';

class AlarmDto {
  const AlarmDto({
    required this.id,
    required this.hour,
    required this.minute,
    required this.schedule,
    required this.sound,
    required this.isEnabled,
  });

  final String id;
  final int hour;
  final int minute;
  final String schedule;
  final String sound;
  final bool isEnabled;

  factory AlarmDto.fromJson(Map<String, dynamic> json) {
    return AlarmDto(
      id: json['id'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      schedule: json['schedule'] as String,
      sound: json['sound'] as String,
      isEnabled: json['isEnabled'] as bool,
    );
  }

  factory AlarmDto.fromDomain(Alarm alarm) {
    return AlarmDto(
      id: alarm.id,
      hour: alarm.hour,
      minute: alarm.minute,
      schedule: alarm.schedule,
      sound: alarm.sound,
      isEnabled: alarm.isEnabled,
    );
  }

  Alarm toDomain() {
    return Alarm(
      id: id,
      hour: hour,
      minute: minute,
      schedule: schedule,
      sound: sound,
      isEnabled: isEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': hour,
      'minute': minute,
      'schedule': schedule,
      'sound': sound,
      'isEnabled': isEnabled,
    };
  }
}
