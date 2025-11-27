import 'package:flutter/material.dart';
import 'journal_entry.dart';

class ReadJournalScreen extends StatelessWidget {
  final JournalEntry entry;

  ReadJournalScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entry.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji
              Text(entry.emoji, style: TextStyle(fontSize: 40)),

              SizedBox(height: 12),

              // Date
              Text(
                "Created: ${entry.createdAt.toLocal()}",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),

              SizedBox(height: 20),

              // Stress Level
              Text("Stress Level: ${entry.stressLevel}"),
              SizedBox(height: 6),
              LinearProgressIndicator(value: entry.stressLevel / 100),

              SizedBox(height: 20),

              // Content
              Text(entry.content, style: TextStyle(fontSize: 16, height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }
}
