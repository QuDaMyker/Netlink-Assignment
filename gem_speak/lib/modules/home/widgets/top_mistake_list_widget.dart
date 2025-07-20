import 'package:flutter/material.dart';
import 'package:tool_core/models/top_mistake.dart';

class TopMistakesListWidget extends StatelessWidget {
  final TopMistake? mistake;

  const TopMistakesListWidget({super.key, required this.mistake});

  @override
  Widget build(BuildContext context) {
    final items = mistake?.phonemeMistakes ?? [];

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("No top mistakes found"),
      );
    }

    return Card(
      margin: const EdgeInsets.all(12),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final phoneme = items[index];
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(phoneme.phoneme),
            subtitle: Text("Incorrect count: ${phoneme.mistakeCount}"),
          );
        },
      ),
    );
  }
}
