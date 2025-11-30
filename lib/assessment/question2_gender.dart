import 'package:flutter/material.dart';

class Question2Gender extends StatefulWidget {
  @override
  State<Question2Gender> createState() => _Question2GenderState();
}

class _Question2GenderState extends State<Question2Gender> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4F2),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),

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
                      "2 of 7",
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
                "What's your official\ngender?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF5B4636),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40),

              genderCard(
                title: "I am Male",
                icon: Icons.male,
                imagePath: "assets/male.png",
                value: "male",
              ),

              SizedBox(height: 20),

              genderCard(
                title: "I am Female",
                icon: Icons.female,
                imagePath: "assets/famale.png",
                value: "female",
              ),

              SizedBox(height: 150),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/q3");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFD5E4C4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Prefer to skip, thanks",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF6E8A55),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.close, color: Color(0xFF6E8A55)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  if (selectedGender != null) {
                    Navigator.pushNamed(context, "/q3");
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A342E),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      "Continue →",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget genderCard({
    required String title,
    required IconData icon,
    required String imagePath,
    required String value,
  }) {
    final isSelected = selectedGender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Color(0xFF5B4636) : Colors.grey.shade300,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF5B4636), size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF5B4636),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: 105,
                height: 105,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
