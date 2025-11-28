import 'package:flutter/material.dart';

class Question2Gender extends StatefulWidget {
  @override
  _Question2GenderState createState() => _Question2GenderState();
}

class _Question2GenderState extends State<Question2Gender> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EE),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF5B4636),
                  width: 2.2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF5B4636),
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // TITLE
            const Text(
              "What's your official\ngender?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFF5B4636),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // CARD - MALE
            genderCard(
              title: "I am Male",
              icon: Icons.male,
              imagePath: "assets/male.png",
              value: "male",
            ),
            const SizedBox(height: 20),

            // CARD - FEMALE
            genderCard(
              title: "I am Female",
              icon: Icons.female,
              imagePath: "assets/female.png",
              value: "female",
            ),

            const Spacer(),

            // SKIP BUTTON
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/q3");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E4C4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
            const SizedBox(height: 20),

            // CONTINUE BUTTON
            GestureDetector(
              onTap: () {
                if (selectedGender != null) {
                  Navigator.pushNamed(context, "/q3");
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A342E),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
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

            const SizedBox(height: 30),
          ],
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
    bool isSelected = selectedGender == value;

    return GestureDetector(
      onTap: () {
        setState(() => selectedGender = value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B4636) : Colors.grey.shade300,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF5B4636), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
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
