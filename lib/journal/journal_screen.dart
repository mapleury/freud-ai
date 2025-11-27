import 'package:final_project/auth/auth_service.dart';
import 'package:final_project/journal/journal_history_screen.dart';
import 'package:flutter/material.dart';
import 'journal_service.dart';
import 'journal_entry.dart';
import 'create_journal_screen.dart';

class JournalScreen extends StatefulWidget {
  @override
  State<JournalScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<JournalScreen> {
  final service = JournalService();
  int count = 0;
  Map<DateTime, bool> dayHasEntry = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Get total count
    final stream = service.getEntries();
    stream.listen((entries) {
      setState(() {
        count = entries.length;
      });
    });

    // Build mini calendar data for last 7 days
    final today = DateTime.now();
    Map<DateTime, bool> temp = {};

    for (int i = 0; i < 7; i++) {
      final day = today.subtract(Duration(days: i));
      final entries = await service.getEntriesForDate(day);
      temp[DateTime(day.year, day.month, day.day)] = entries.isNotEmpty;
    }

    setState(() {
      dayHasEntry = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dayList = List.generate(7, (i) => today.subtract(Duration(days: i)));

    return Scaffold(
      appBar: AppBar(title: Text("MindLog")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await AuthService().signOutAndGoToLogin(context);
              },
            ),

            // Journal Count
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Total Journals: $count",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Mini Calendar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: dayList.map((day) {
                final thisDay = DateTime(day.year, day.month, day.day);
                final hasEntry = dayHasEntry[thisDay] ?? false;

                Color circleColor;

                if (thisDay.day == today.day &&
                    thisDay.month == today.month &&
                    thisDay.year == today.year) {
                  // Today
                  circleColor = hasEntry ? Colors.red : Colors.grey;
                } else {
                  // Previous days
                  circleColor = hasEntry ? Colors.green : Colors.grey;
                }

                return Column(
                  children: [
                    Text("${day.day}", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 6),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            // Buttons
            ElevatedButton(
              child: Text('Write Journal'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreateJournalScreen()),
                );
                loadData();
              },
            ),
            ElevatedButton(
              child: Text('History'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
