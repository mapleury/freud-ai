// lib/pages/mood/add_mood_page.dart
import 'package:final_project/mood-tracker/mood_service.dart';
import 'package:flutter/material.dart';

class AddMoodPage extends StatefulWidget {
  final DateTime date;

  const AddMoodPage({super.key, required this.date});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final MoodService _moodService = MoodService();
  final PageController _pc = PageController();
  int _index = 0;

  // Replace with your desired emojis or images later
  final List<String> _emojis = ['😃', '🙂', '😐', '😕', '😞', '😡', '😴'];

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final existing = await _moodService.getMoodForDate(widget.date);
    if (existing != null) {
      final idx = _emojis.indexOf(existing);
      if (idx >= 0) {
        setState(() => _index = idx);
        _pc.jumpToPage(idx);
      }
    }
  }

  Future<void> _setMood() async {
    final emoji = _emojis[_index];
    await _moodService.setMood(date: widget.date, emoji: emoji);
    // return the emoji so caller knows to refresh
    if (mounted) Navigator.of(context).pop(emoji);
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  String _niceDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final displayDate = _niceDate(widget.date);
    return Scaffold(
      appBar: AppBar(title: Text('Set Mood — $displayDate')),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pc,
              itemCount: _emojis.length,
              onPageChanged: (p) => setState(() => _index = p),
              itemBuilder: (context, i) {
                final emoji = _emojis[i];
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey.shade100,
                  ),
                  child: Text(emoji, style: const TextStyle(fontSize: 120)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _emojis.length; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _index == i ? 12 : 8,
                        height: _index == i ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _index == i ? Colors.deepPurple : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _setMood,
                    child: const Text('Set mood'),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
