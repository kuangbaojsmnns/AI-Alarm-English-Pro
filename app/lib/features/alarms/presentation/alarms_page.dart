import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/page_header.dart';
import '../application/alarm_providers.dart';
import '../domain/entities/alarm.dart';

class AlarmsPage extends ConsumerStatefulWidget {
  const AlarmsPage({super.key});

  @override
  ConsumerState<AlarmsPage> createState() => _AlarmsPageState();
}

class _AlarmsPageState extends ConsumerState<AlarmsPage> {
  final Map<String, bool> _enabledOverrides = {};

  @override
  Widget build(BuildContext context) {
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
            for (final alarm in items) ...[
              _AlarmTile(
                alarm: alarm,
                enabled: _enabledOverrides[alarm.id] ?? alarm.isEnabled,
                onChanged: (value) => setState(() {
                  _enabledOverrides[alarm.id] = value;
                }),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add alarm'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlarmTile extends StatelessWidget {
  const _AlarmTile({
    required this.alarm,
    required this.enabled,
    required this.onChanged,
  });

  final Alarm alarm;
  final bool enabled;
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
        trailing: Switch(value: enabled, onChanged: onChanged),
      ),
    );
  }
}
