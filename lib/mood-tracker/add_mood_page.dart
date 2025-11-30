import 'package:final_project/mood-tracker/mood_history_page.dart';
import 'package:final_project/mood-tracker/mood_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/mood-tracker/mood_service.dart';

class MoodFlowScreen extends StatefulWidget {
  final DateTime date;

  const MoodFlowScreen({super.key, required this.date});

  @override
  State<MoodFlowScreen> createState() => _MoodFlowScreenState();
}

class _MoodFlowScreenState extends State<MoodFlowScreen> {
  final MoodService _moodService = MoodService();
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Color> moodColors = [
    Color(0xFFA694F5),
    Color(0xFFED7E1C),
    Color(0xFF926247),
    Color(0xFFFFCE5C),
    Color(0xFF9BB167),
  ];

  final List<String> moodImages = [
    'assets/mood1.png',
    'assets/mood2.png',
    'assets/mood3.png',
    'assets/mood4.png',
    'assets/mood5.png',
  ];

  final List<String> moodNames = [
    "Depressed",
    "Sad",
    "Neutral",
    "Happy",
    "Overjoyed",
  ];

  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final existing = await _moodService.getMoodForDate(widget.date);
    if (existing != null) {
      final idx = moodNames.indexOf(existing);
      if (idx >= 0) {
        setState(() => currentPage = idx);
        _controller.jumpToPage(idx);
      }
    }
  }

  Future<void> _saveMood(String mood) async {
    await _moodService.setMood(date: widget.date, emoji: mood);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MoodHistoryPage()),
      );
    }
  }

  void nextPage() {
    if (currentPage < moodNames.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: moodNames.length,
        onPageChanged: (i) => setState(() => currentPage = i),
        itemBuilder: (context, index) {
          return MoodPage(
            bgColor: moodColors[index],
            image: moodImages[index],
            onNext: nextPage,
            onSetMood: () => _saveMood(moodNames[index]),
          );
        },
      ),
    );
  }
}
