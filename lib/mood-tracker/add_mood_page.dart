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

  Future<void> _saveMood() async {
    final mood = moodNames[currentPage];
    await _moodService.setMood(date: widget.date, emoji: mood);
    if (mounted) Navigator.pop(context, mood);
  }

  String _niceDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void nextPage() {
    if (currentPage < 4) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = _niceDate(widget.date);

    return Scaffold(
      backgroundColor: moodColors[currentPage],
      body: Stack(
        children: [
          // HEADER
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Set Mood – $displayDate",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),

          // PAGEVIEW (UI kamu tetap)
          PageView.builder(
            controller: _controller,
            itemCount: 5,
            onPageChanged: (i) => setState(() => currentPage = i),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    moodImages[index],
                    width: 260,
                    height: 260,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    moodNames[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (index < 4)
                    ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                      ),
                      child: const Text("Next"),
                    ),
                ],
              );
            },
          ),

          // BOTTOM: dots + SAVE + CANCEL
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0.25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      moodNames.length,
                      (i) => AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == i ? 12 : 8,
                        height: currentPage == i ? 12 : 8,
                        decoration: BoxDecoration(
                          color:
                              currentPage == i ? Colors.white : Colors.white70,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveMood,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      child: const Text("Save mood"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
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
