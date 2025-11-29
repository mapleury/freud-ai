import 'package:final_project/assessment/assesment_model.dart';
import 'package:final_project/assessment/assesment_service.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssessmentResultScreen extends StatefulWidget {
  final bool physicalDistress;
  final int stressLevel;
  final String? goal;
  final String? gender;
  final int? age;
  final double? moodValue;
  final double? stressLevelAnswer;

  const AssessmentResultScreen({
    super.key,
    required this.physicalDistress,
    required this.stressLevel,
    this.goal,
    this.gender,
    this.age,
    this.moodValue,
    this.stressLevelAnswer,
  });

  @override
  State<AssessmentResultScreen> createState() => _AssessmentResultScreenState();
}

class _AssessmentResultScreenState extends State<AssessmentResultScreen> {
  bool _saving = false;
  bool _saved = false;
  String? _error;

  int get _score => widget.stressLevel + (widget.physicalDistress ? 2 : 0);

  String get _backgroundImage {
    if (_score <= 5) {
      return 'assets/mental-health-assessment1.png';
    } else if (_score <= 8) {
      return 'assets/mental-health-assessment2.png';
    } else {
      return 'assets/mental-health-assessment3.png';
    }
  }

  Future<void> _saveResult() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _error = 'You must be signed in to save results.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in first to save assessment.')),
      );
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final assessment = AssessmentModel(
      uid: user.uid,
      physicalDistress: widget.physicalDistress,
      stressLevel: widget.stressLevel,
      score: _score,
      timestamp: DateTime.now(),
      goal: widget.goal,
      gender: widget.gender,
      age: widget.age,
      moodValue: widget.moodValue,
      stressLevelAnswer: widget.stressLevelAnswer,
    );

    try {
      await AssessmentService().saveAssessment(assessment);
      setState(() => _saved = true);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Assessment saved.')));
    } catch (e) {
      setState(() => _error = e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool highStress = _score > 5;
    final Color scoreColor = highStress ? Colors.red : Colors.green;
    final IconData feelingIcon =
        highStress ? Icons.sentiment_dissatisfied : Icons.sentiment_satisfied;
    final String feelingText = highStress ? 'Stressed' : 'Calm';
    final String description = highStress
        ? 'Your stress level is high. Consider taking a break and practicing relaxation techniques.'
        : 'You are managing stress well. Keep it up!';
    final int suggestionsCount = highStress ? 5 : 2;
    final String buttonText = _saved ? 'Done' : 'Save Result';
    final IconData buttonIcon = _saved ? Icons.check : Icons.save;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Freud Score",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                CircleScore(score: _score, mainColor: scoreColor),
                const SizedBox(height: 30),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 42),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "$suggestionsCount AI suggestions",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    Icon(feelingIcon, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      feelingText,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 42),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                
                // BIG BUTTON
                SizedBox(
                  width: double.infinity, // makes button full width
                  height: 60, // fixed height
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : _saved
                            ? () async {
                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await AuthService().markAssessmentDone(uid);
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            : _saveResult,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                buttonText,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(buttonIcon, color: Colors.white),
                            ],
                          ),
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

Widget CircleScore({required int score, required Color mainColor}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 340,
        height: 340,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      Container(
        width: 310,
        height: 310,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.95),
        ),
        alignment: Alignment.center,
        child: Text(
          "$score",
          style: TextStyle(
            fontSize: 100,
            fontFamily: 'Urbanist',
            color: mainColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ],
  );
}
