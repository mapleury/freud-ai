import 'package:final_project/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:final_project/mood-tracker/mood_service.dart';
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
      MaterialPageRoute(builder: (_) => MoodFlowScreen(date: DateTime.now())),
    );
    if (res != null) _loadHistory();
  }

  String moodToResultImage(String moodRaw) {
    final mood = moodRaw.trim().toLowerCase();
    switch (mood) {
      case "overjoyed":
        return "assets/result-overjoyed.png";
      case "happy":
        return "assets/result-happy.png";
      case "neutral":
        return "assets/result-neutral.png";
      case "sad":
        return "assets/result-sad.png";
      case "depressed":
        return "assets/result-depressed.png";
      default:
        return "assets/result-neutral.png";
    }
  }

  Widget moodCard(String mood, String dateString) {
    final d = DateTime.tryParse(dateString) ?? DateTime.now();
    final day = DateFormat('d').format(d);
    final month = DateFormat('MMM').format(d).toUpperCase();

    final img = moodToResultImage(mood);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F3EE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A7F75),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  day,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4D3A2A),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: GestureDetector(
              onTap: () async {
                final res = await Navigator.push<String?>(
                  context,
                  MaterialPageRoute(builder: (_) => MoodFlowScreen(date: d)),
                );
                if (res != null) _loadHistory();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mood,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4D3A2A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.favorite, size: 17, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        "96bpm",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          color: Color(0xFF8A7F75),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.add, size: 17, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        "121sys",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          color: Color(0xFF8A7F75),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Image.asset(img, width: 45, height: 45, fit: BoxFit.contain),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAdd,
        backgroundColor: const Color(0xFF704A33),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4F3422),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 45,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                            );
                          },
                          child: Image.asset(
                            'assets/back_button.png',
                            width: 42,
                            height: 42,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 22,
                        bottom: 85,
                        child: Text(
                          "My Mood",
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF704A33),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "History",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: _items.isEmpty
                      ? const Center(
                          child: Text(
                            "No moods saved yet.",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 90),
                          itemCount: _items.length,
                          itemBuilder: (context, i) {
                            final it = _items[i];
                            return moodCard(
                              it['emoji'] ?? '',
                              it['date'] ?? '',
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
