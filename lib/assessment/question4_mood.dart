import 'package:flutter/material.dart';

class Question4Mood extends StatefulWidget {
  @override
  _Question4MoodState createState() => _Question4MoodState();
}

class _Question4MoodState extends State<Question4Mood> {
  double moodValue = 0.5;

  final List<Map<String, dynamic>> moods = [
    {"label": "Sad", "icon": Icons.sentiment_dissatisfied_outlined},
    {"label": "Neutral", "icon": Icons.sentiment_neutral_outlined},
    {"label": "Happy", "icon": Icons.sentiment_satisfied_outlined},
  ];

  int getSelectedMoodIndex() {
    if (moodValue < 0.33)
      return 0;
    else if (moodValue < 0.67)
      return 1;
    else
      return 2;
  }

  @override
  Widget build(BuildContext context) {
    final selectedMoodIndex = getSelectedMoodIndex();

    return Scaffold(
      backgroundColor: Color(0xFFF7F4F2),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            // HEADER
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assessment",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Color(0xFF4B2E23),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEAE6),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "4 of 7",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        color: Color(0xFF4B2E23),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "How do you feel today?",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B2E23),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 60),

            Icon(
              moods[selectedMoodIndex]["icon"],
              size: 80,
              color: Color(0xFF4B2E23), 
            ),
            SizedBox(height: 20),
            Text(
              moods[selectedMoodIndex]["label"],
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4B2E23),
              ),
            ),

            SizedBox(height: 40),

            // LINEAR SLIDER
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 32.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.brown,
                  inactiveTrackColor: Colors.brown.withOpacity(0.3),
                  thumbColor: Colors.brown,
                  overlayColor: Colors.brown.withOpacity(0.2),
                  trackHeight: 8,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                ),
                child: Slider(
                  value: moodValue,
                  min: 0.0,
                  max: 1.0,
                  divisions: 100,
                  onChanged: (value) {
                    setState(() {
                      moodValue = value;
                    });
                  },
                ),
              ),
            ),

            Spacer(),

            // CONTINUE BUTTON
            Padding(
              padding: EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/q5"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4B2E23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Continue →",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 16,
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
    );
  }
}
