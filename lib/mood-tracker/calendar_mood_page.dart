// lib/pages/mood/calendar_mood_page.dart
import 'package:final_project/mood-tracker/mood_service.dart';
import 'package:flutter/material.dart';
import 'add_mood_page.dart';
import 'mood_history_page.dart';

class CalendarMoodPage extends StatefulWidget {
  const CalendarMoodPage({super.key});

  @override
  State<CalendarMoodPage> createState() => _CalendarMoodPageState();
}

class _CalendarMoodPageState extends State<CalendarMoodPage> {
  final MoodService _moodService = MoodService();
  Map<String, String> _weekMoods = {}; // dateKey -> emoji
  DateTime _monday = _computeMonday(DateTime.now());
  bool _loading = true;

  static DateTime _computeMonday(DateTime date) {
    // Flutter DateTime.weekday: Mon=1 .. Sun=7
    final int delta = date.weekday - 1;
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: delta));
  }

  List<DateTime> get _weekDates =>
      List.generate(7, (i) => _monday.add(Duration(days: i)));

  @override
  void initState() {
    super.initState();
    _loadWeek();
  }

  Future<void> _loadWeek() async {
    setState(() => _loading = true);
    final dates = _weekDates;
    final map = await _moodService.getMoodsForDates(dates);
    setState(() {
      _weekMoods = map;
      _loading = false;
    });
  }

  Future<void> _openAddPage(DateTime date) async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (_) => AddMoodPage(date: date)),
    );

    // if result non-null, refresh
    if (result != null) {
      await _loadWeek();
    }
  }

  void _previousWeek() {
    setState(() {
      _monday = _monday.subtract(const Duration(days: 7));
    });
    _loadWeek();
  }

  void _nextWeek() {
    setState(() {
      _monday = _monday.add(const Duration(days: 7));
    });
    _loadWeek();
  }

  @override
  Widget build(BuildContext context) {
    final dates = _weekDates;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Calendar (Mon–Sun)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MoodHistoryPage()),
              );
            },
            tooltip: 'History',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _previousWeek,
                      ),
                      Text(
                        '${dates.first.month}/${dates.first.day} - ${dates.last.month}/${dates.last.day}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _nextWeek,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 7,
                    childAspectRatio: 0.9,
                    children: List.generate(7, (i) {
                      final d = dates[i];
                      final key =
                          '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
                      final emoji = _weekMoods[key];

                      return GestureDetector(
                        onTap: () => _openAddPage(d),
                        child: Card(
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // Weekday short
                                [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun',
                                ][i],
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${d.day}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                emoji ?? '',
                                style: const TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add mood for today',
        onPressed: () {
          _openAddPage(DateTime.now());
        },
      ),
    );
  }
}
