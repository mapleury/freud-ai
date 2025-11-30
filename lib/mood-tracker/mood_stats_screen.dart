import 'package:final_project/mood-tracker/add_mood_page.dart';
import 'package:flutter/material.dart';

class MoodStatsScreen extends StatelessWidget {
  const MoodStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        
          Positioned.fill(
            child: Image.asset(
              'assets/mood-stats.png',   
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => MoodFlowScreen(date: DateTime.now())));
                },
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF8AAF53), 
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 45,
                      color: Colors.white,
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
