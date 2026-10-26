import 'package:flutter/material.dart';
import '../../../core/widgets/page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PageHeader(
            title: 'Good morning',
            subtitle: 'A little English, before the day begins.',
          ),
          const SizedBox(height: 28),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NEXT ALARM', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 12),
                  Text('7:00 AM', style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  const Text('Weekdays · Gentle piano'),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Preview morning lesson'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TODAY’S PHRASE', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 12),
                  Text(
                    'The early bird catches the worm.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('早起的鸟儿有虫吃。'),
                  const SizedBox(height: 14),
                  Text('A2 · Everyday English', style: TextStyle(color: colors.primary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(child: _StatCard(label: 'DAY STREAK', value: '7')),
              SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'WORDS LEARNED', value: '128')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
