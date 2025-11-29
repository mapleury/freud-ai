import 'package:final_project/assessment/calculating_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/assessment/assesment_result.dart';
import 'package:final_project/auth/auth_service.dart';

class Question7Stress extends StatefulWidget {
  final bool? physicalDistress;

  const Question7Stress({
    super.key,
    this.physicalDistress,
  });

  @override
  _Question7StressState createState() => _Question7StressState();
}

class _Question7StressState extends State<Question7Stress> {
  int _selected = 3;
  final _auth = AuthService();

  Widget _levelChip(int value) {
    final selected = _selected == value;

    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: selected ? 55 : 40,
        height: selected ? 55 : 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4B2E23) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF4B2E23) : const Color(0xFF4B2E23).withOpacity(0.45),
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF4B2E23),
            fontSize: selected ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _goResult() async {
    final user = _auth.currentUser;

    if (user != null) {
      await _auth.markAssessmentDone(user.uid);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CalculatingAssessmentScreen(
          physicalDistress: widget.physicalDistress ?? false,
          stressLevel: _selected,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E23);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 30),

              // HEADER ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assessment",
                    style: TextStyle(
                      color: brown,
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
                      "7 of 7",
                      style: TextStyle(
                        fontSize: 14,
                        color: brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              // TITLE
              Text(
                "How would you rate your\nstress level?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),

              SizedBox(height: 60),

              // STRESS LEVEL CHIPS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (i) => _levelChip(i + 1)),
              ),

              SizedBox(height: 25),

              // LABEL
              Text(
                _selected == 1
                    ? "Very Calm"
                    : _selected == 2
                        ? "Slightly Stressed"
                        : _selected == 3
                            ? "Moderately Stressed"
                            : _selected == 4
                                ? "Very Stressed"
                                : "Extremely Stressed Out",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: brown,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Spacer(),

              // BUTTON CONTINUE
              Container(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _goResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    "Continue  →",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
