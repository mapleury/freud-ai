import 'package:flutter/material.dart';

class MindfulHoursScreen extends StatelessWidget {
  const MindfulHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mindful-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/back_button.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Mindful Hours",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 80),

                const Center(
                  child: Text(
                    "5.21",
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const Center(
                  child: Text(
                    "Mindful Hours",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 95),

                Center(
                  child: Container(
                    width: 89,
                    height: 89,
                    decoration: BoxDecoration(
                      color: Color(0xFF5A3A27),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () => Navigator.pushNamed(context, '/breath'),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Mindful Hour History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown,
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView(
                    children: [
                      MindfulItem(
                        title: "Relaxed Sate",
                        tag: "Chirping Bird",
                        current: "08:33",
                        total: "60:00",
                      ),
                      MindfulItem(
                        title: "Relaxed Sate",
                        tag: "Fireplace",
                        current: "12:20",
                        total: "50:00",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MindfulItem extends StatelessWidget {
  final String title;
  final String tag;
  final String current;
  final String total;

  const MindfulItem({
    super.key,
    required this.title,
    required this.tag,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xFFF7F4F2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.play_arrow, color: Colors.brown, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF9BB167),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade700,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(current), Text(total)],
          ),
        ],
      ),
    );
  }
}
