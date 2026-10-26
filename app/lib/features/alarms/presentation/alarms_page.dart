import 'package:flutter/material.dart';
import '../../../core/widgets/page_header.dart';

class AlarmsPage extends StatefulWidget {
  const AlarmsPage({super.key});

  @override
  State<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  bool _weekdayAlarmEnabled = true;
  bool _weekendAlarmEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PageHeader(
            title: 'Your alarms',
            subtitle: 'Make a little room for English each morning.',
          ),
          const SizedBox(height: 24),
          _AlarmTile(
            time: '7:00',
            period: 'AM',
            schedule: 'Weekdays',
            enabled: _weekdayAlarmEnabled,
            onChanged: (value) => setState(() => _weekdayAlarmEnabled = value),
          ),
          const SizedBox(height: 12),
          _AlarmTile(
            time: '8:30',
            period: 'AM',
            schedule: 'Saturday, Sunday',
            enabled: _weekendAlarmEnabled,
            onChanged: (value) => setState(() => _weekendAlarmEnabled = value),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add alarm'),
          ),
        ],
      ),
    );
  }
}

class _AlarmTile extends StatelessWidget {
  const _AlarmTile({
    required this.time,
    required this.period,
    required this.schedule,
    required this.enabled,
    required this.onChanged,
  });

  final String time;
  final String period;
  final String schedule;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: const Icon(Icons.alarm_rounded, size: 30),
        title: Text('$time $period', style: Theme.of(context).textTheme.headlineSmall),
        subtitle: Text('$schedule · Gentle piano'),
        trailing: Switch(value: enabled, onChanged: onChanged),
      ),
    );
  }
}
