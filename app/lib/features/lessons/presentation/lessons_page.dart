import 'package:flutter/material.dart';
import '../../../core/widgets/page_header.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PageHeader(
            title: 'Your lessons',
            subtitle: 'Short practice that fits into your morning.',
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(18),
              leading: const CircleAvatar(child: Icon(Icons.wb_sunny_outlined)),
              title: const Text('A brighter start'),
              subtitle: const Text('Everyday English · 5 min · A2'),
              trailing: const Icon(Icons.play_circle_outline_rounded),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(18),
              leading: const CircleAvatar(child: Icon(Icons.chat_bubble_outline)),
              title: const Text('At the coffee shop'),
              subtitle: const Text('Conversation · 8 min · A2'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(18),
              leading: const CircleAvatar(child: Icon(Icons.travel_explore_outlined)),
              title: const Text('Finding your way'),
              subtitle: const Text('Travel English · 6 min · B1'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
