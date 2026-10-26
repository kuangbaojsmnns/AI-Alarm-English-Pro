import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/page_header.dart';
import '../application/alarm_providers.dart';
import '../domain/entities/alarm.dart';

class AlarmsPage extends ConsumerWidget {
  const AlarmsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarms = ref.watch(alarmsProvider);

    return SafeArea(
      child: alarms.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load your alarms.'),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => ref.invalidate(alarmsProvider),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
        data: (items) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const PageHeader(
              title: 'Your alarms',
              subtitle: 'Make a little room for English each morning.',
            ),
            const SizedBox(height: 24),
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No alarms yet. Add one to get started.'),
              ),
            for (final alarm in items) ...[
              _AlarmTile(
                alarm: alarm,
                onChanged: (value) => _setEnabled(context, ref, alarm, value),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: () => _addAlarm(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add alarm'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setEnabled(
    BuildContext context,
    WidgetRef ref,
    Alarm alarm,
    bool enabled,
  ) async {
    try {
      await ref.read(alarmsProvider.notifier).setEnabled(alarm.id, enabled);
    } on Object {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save this alarm.')),
      );
    }
  }

  Future<void> _addAlarm(BuildContext context, WidgetRef ref) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !context.mounted) return;

    final alarm = Alarm(
      id: 'alarm-${DateTime.now().millisecondsSinceEpoch}',
      hour: time.hour,
      minute: time.minute,
      schedule: 'Every day',
      sound: 'Gentle piano',
      isEnabled: true,
    );

    try {
      await ref.read(alarmsProvider.notifier).addAlarm(alarm);
    } on Object {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save this alarm.')),
      );
    }
  }
}

class _AlarmTile extends StatelessWidget {
  const _AlarmTile({
    required this.alarm,
    required this.onChanged,
  });

  final Alarm alarm;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: const Icon(Icons.alarm_rounded, size: 30),
        title: Text(
          alarm.formattedTime,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Text('${alarm.schedule} · ${alarm.sound}'),
        trailing: Switch(value: alarm.isEnabled, onChanged: onChanged),
      ),
    );
  }
}
