class Alarm {
  const Alarm({
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

  String get formattedTime {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final minuteText = minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'AM' : 'PM';
    return '$hour12:$minuteText $period';
  }

  Alarm copyWith({bool? isEnabled}) {
    return Alarm(
      id: id,
      hour: hour,
      minute: minute,
      schedule: schedule,
      sound: sound,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
