import 'package:flutter/material.dart';
import 'journal_service.dart';
import 'journal_entry.dart';
import 'read_journal_screen.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: StreamBuilder<List<JournalEntry>>(
        stream: JournalService().getEntries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final entries = snapshot.data!;

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (c, i) {
              final e = entries[i];

              return ListTile(
                leading: Text(
                  e.emoji,
                  style: TextStyle(fontSize: 28),
                ),
                title: Text(e.title),
                subtitle: Text(
                  '${e.createdAt.toLocal()}',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReadJournalScreen(entry: e),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
