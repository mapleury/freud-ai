import 'package:final_project/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';
import 'journal_service.dart';
import 'journal_entry.dart';
import 'create_journal_screen.dart';
import 'journal_history_screen.dart';

class JournalHomeScreen extends StatefulWidget {
  const JournalHomeScreen({super.key});

  @override
  State<JournalHomeScreen> createState() => _JournalHomeScreenState();
}

class _JournalHomeScreenState extends State<JournalHomeScreen> {
  final service = JournalService();
  int count = 0;

  // For 7-day calendar
  Map<DateTime, bool> dayHasEntry = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Total count
    service.getEntries().listen((entries) {
      if (mounted) {
        setState(() => count = entries.length);
      }
    });

    // mini calendar
    final today = DateTime.now();
    Map<DateTime, bool> temp = {};

    for (int i = 0; i < 7; i++) {
      final day = today.subtract(Duration(days: i));
      final entries = await service.getEntriesForDate(day);
      temp[DateTime(day.year, day.month, day.day)] = entries.isNotEmpty;
    }

    if (mounted) {
      setState(() => dayHasEntry = temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dayList = List.generate(7, (i) => today.subtract(Duration(days: i)));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/bg.png", fit: BoxFit.cover),
          ),

          // Header
          Positioned(
            top: 55,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },

              child: Row(
                children: [
                  Image.asset("assets/back_button.png", width: 50),
                  const SizedBox(width: 10),
                  Text(
                    "Health Journal",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            bottom: 325,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$count",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 120,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Journals this year.",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 340,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddJournalScreen(),
                    ),
                  );
                  loadData();
                },
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4F3422),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 35),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + See All
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Journal Statistics",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF4F3422),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HistoryScreen()),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF9BB167),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 45),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["M", "T", "W", "T", "F", "S", "S"]
                        .map(
                          (d) => Text(
                            d,
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: const Color(0xFF736B66),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: dayList.map((day) {
                      final d = DateTime(day.year, day.month, day.day);
                      final hasEntry = dayHasEntry[d] ?? false;

                      String type;
                      if (!hasEntry) {
                        type = "skip";
                      } else {
                        type = "positive";
                      }

                      return circle(type);
                    }).toList(),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Legend(color: Color(0xFFE7DEDB), text: "Skipped"),
                      SizedBox(width: 25),
                      Legend(color: Color(0xFF9BB167), text: "Positive"),
                      SizedBox(width: 25),
                      Legend(color: Color(0xFFED7E1B), text: "Negative"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget circle(String type) {
  const map = {
    'skip': Color(0xFFE7DEDB),
    'positive': Color(0xFF9BB167),
    'negative': Color(0xFFED7E1B),
  };
  return Container(
    width: 38,
    height: 38,
    decoration: BoxDecoration(color: map[type], shape: BoxShape.circle),
  );
}

class Legend extends StatelessWidget {
  final Color color;
  final String text;
  const Legend({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF736B66),
          ),
        ),
      ],
    );
  }
}
