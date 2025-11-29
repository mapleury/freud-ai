import 'package:final_project/mood/mood_history_screen.dart';
import 'package:flutter/material.dart';
import 'mood_page.dart';

class MoodFlowScreen extends StatefulWidget {
  const MoodFlowScreen({super.key});

  @override
  State<MoodFlowScreen> createState() => _MoodFlowScreenState();
}

class _MoodFlowScreenState extends State<MoodFlowScreen> {
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
    'assets/images/mood1.png',
    'assets/images/mood2.png',
    'assets/images/mood3.png',
    'assets/images/mood4.png',
    'assets/images/mood5.png',
  ];

  final List<String> moodNames = [
    "Happy",
    "Excited",
    "Calm",
    "Bored",
    "Relaxed",
  ];

  void nextPage() {
    if (currentPage < 4) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void setMood(String moodName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoodHistoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: 5,
        onPageChanged: (i) => setState(() => currentPage = i),
        itemBuilder: (context, index) {
          return MoodPage(
            bgColor: moodColors[index],
            image: moodImages[index],
            onNext: nextPage,
            onSetMood: () => setMood(moodNames[index]),
          );
        },
      ),
    );
  }
}