import 'package:flutter/material.dart';
import '../../../core/widgets/page_header.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PageHeader(
            title: 'Your words',
            subtitle: 'Keep useful words close and growing.',
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('WEEKLY GOAL'),
                  const SizedBox(height: 12),
                  const Text('12 of 20 words'),
                  const SizedBox(height: 12),
                  const LinearProgressIndicator(value: 0.6),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _WordTile(word: 'brisk', pronunciation: '/brɪsk/', meaning: 'quick and full of energy'),
          const _WordTile(word: 'routine', pronunciation: '/ruːˈtiːn/', meaning: 'a regular way of doing things'),
          const _WordTile(word: 'refresh', pronunciation: '/rɪˈfreʃ/', meaning: 'to feel rested and lively again'),
        ],
      ),
    );
  }
}

class _WordTile extends StatelessWidget {
  const _WordTile({
    required this.word,
    required this.pronunciation,
    required this.meaning,
  });

  final String word;
  final String pronunciation;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(word, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('$pronunciation · $meaning'),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.volume_up_outlined),
          tooltip: 'Play pronunciation',
        ),
      ),
    );
  }
}
