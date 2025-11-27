// lib/pages/mood/mood_history_page.dart
import 'package:final_project/mood-tracker/mood_service.dart';
import 'package:flutter/material.dart';
import 'add_mood_page.dart';

class MoodHistoryPage extends StatefulWidget {
  const MoodHistoryPage({super.key});

  @override
  State<MoodHistoryPage> createState() => _MoodHistoryPageState();
}

class _MoodHistoryPageState extends State<MoodHistoryPage> {
  final MoodService _moodService = MoodService();
  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _loading = true);
    final rows = await _moodService.fetchAllMoods(limit: 500);
    setState(() {
      _items = rows;
      _loading = false;
    });
  }

  Future<void> _openAdd() async {
    final res = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => AddMoodPage(date: DateTime.now())),
    );
    if (res != null) await _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood History')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
          ? const Center(child: Text('No moods saved yet.'))
          : RefreshIndicator(
              onRefresh: _loadHistory,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  final it = _items[i];
                  final date = it['date'] as String? ?? '';
                  final emoji = it['emoji'] as String? ?? '';
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Text(
                        emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(date),
                      subtitle: const Text('Tap to edit'),
                      onTap: () async {
                        // Open add page to edit that date
                        // parse date string
                        final parts = date.split('-');
                        if (parts.length == 3) {
                          final d = DateTime(
                            int.tryParse(parts[0]) ?? DateTime.now().year,
                            int.tryParse(parts[1]) ?? 1,
                            int.tryParse(parts[2]) ?? 1,
                          );
                          final res = await Navigator.push<String?>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddMoodPage(date: d),
                            ),
                          );
                          if (res != null) await _loadHistory();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
