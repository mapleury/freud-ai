import 'package:flutter/material.dart';

class Question1Goal extends StatefulWidget {
  @override
  _Question1GoalState createState() => _Question1GoalState();
}

class _Question1GoalState extends State<Question1Goal> {
  String? selected;

  List<Map<String, dynamic>> goals = [
    {"icon": Icons.favorite_border, "text": "I wanna reduce stress"},
    {"icon": Icons.psychology_alt, "text": "I wanna try AI Therapy"},
    {"icon": Icons.flag_outlined, "text": "I want to cope with trauma"},
    {"icon": Icons.person_outline, "text": "I want to be a better person"},
    {"icon": Icons.coffee, "text": "Just trying out the app, mate!"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4F2),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF7F4F2),
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assessment",
                    style: TextStyle(
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
                      "1 of 8",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4B2E23),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              Text(
                "What's your health goal \nfor today?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4B2E23),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 30),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: goals.map((item) {
                    final text = item["text"];
                    final icon = item["icon"];
                    final isSelected = selected == text;

                    return GestureDetector(
                      onTap: () => setState(() => selected = text),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        margin: EdgeInsets.only(bottom: 14),
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF9BB167)
                              : Color(0xFFEDEAE6),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color:
                                  isSelected ? Colors.white : Colors.grey,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Colors.white
                                      : Color(0xFF4B2E23),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: isSelected ? Colors.white : Colors.brown,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 12),

              ElevatedButton(
                onPressed: selected == null
                    ? null
                    : () {
                        Navigator.pushNamed(context, "/q2");
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B2E23),
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  "Continue  →",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
