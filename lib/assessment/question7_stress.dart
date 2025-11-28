import 'package:flutter/material.dart';
import 'package:final_project/assesment/assesment_result.dart';
import 'package:final_project/auth/auth_service.dart';

class Question7Stress extends StatefulWidget {
  final bool physicalDistress;  

  const Question7Stress({
    super.key,
    required this.physicalDistress,
  });

  @override
  _Question7StressState createState() => _Question7StressState();
}

class _Question7StressState extends State<Question7Stress> {
  double stress = 3;
  final _auth = AuthService();

  String label() {
    switch (stress.toInt()) {
      case 1:
        return "Very Calm";
      case 2:
        return "Slightly Stressed";
      case 3:
        return "Moderately Stressed";
      case 4:
        return "Very Stressed";
      case 5:
        return "Extremely Stressed Out";
      default:
        return "";
    }
  }

  Future<void> _goResult() async {
    final user = _auth.currentUser;

    if (user != null) {
      await _auth.markAssessmentDone(user.uid);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssessmentResult(
          physicalDistress: widget.physicalDistress,
          stressLevel: stress.toInt(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4A342E),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "How would you rate your\nstress level?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF5B4636),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      stress.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A342E),
                      ),
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        int number = index + 1;
                        bool isActive = number == stress.toInt();

                        return GestureDetector(
                          onTap: () {
                            setState(() => stress = number.toDouble());
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isActive ? 55 : 40,
                            height: isActive ? 55 : 40,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFE38A3B)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                      )
                                    ]
                                  : [],
                              border: Border.all(
                                color: isActive
                                    ? const Color(0xFFE38A3B)
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                number.toString(),
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF4A342E),
                                  fontSize: isActive ? 18 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      label(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xFF5B4636),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // continue button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: GestureDetector(
              onTap: _goResult,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A342E),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: Text(
                    "Continue   →",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
