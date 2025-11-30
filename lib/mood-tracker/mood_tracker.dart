import 'package:final_project/mood-tracker/mood_stats_screen.dart';
import 'package:flutter/material.dart';
class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/mood-tracker.png',  
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 390,   
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoodStatsScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4A2E1A),  
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/filter-icon.png', 
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
