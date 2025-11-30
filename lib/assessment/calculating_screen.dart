import 'dart:async';
import 'package:final_project/assessment/assesment_model.dart';
import 'package:final_project/assessment/assesment_result.dart';
import 'package:final_project/assessment/assesment_service.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalculatingAssessmentScreen extends StatefulWidget {
  final bool physicalDistress;
  final int stressLevel;
  final String? goal;
  final String? gender;
  final int? age;
  final double? moodValue;
  final double? stressLevelAnswer;

  const CalculatingAssessmentScreen({
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
  State<CalculatingAssessmentScreen> createState() =>
      _CalculatingAssessmentScreenState();
}

class _CalculatingAssessmentScreenState
    extends State<CalculatingAssessmentScreen> {
  final AssessmentService _service = AssessmentService();
  bool _saving = true;

  @override
  void initState() {
    super.initState();
    _calculateAndSave();
  }

  Future<void> _calculateAndSave() async {
    int finalScore = widget.stressLevel + (widget.physicalDistress ? 2 : 0);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final model = AssessmentModel(
        uid: user.uid,
        physicalDistress: widget.physicalDistress,
        stressLevel: widget.stressLevel,
        score: finalScore,
        timestamp: DateTime.now(),
        goal: widget.goal,
        gender: widget.gender,
        age: widget.age,
        moodValue: widget.moodValue,
        stressLevelAnswer: widget.stressLevelAnswer,
      );

      try {
        await _service.saveAssessment(model);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save assessment: $e')),
          );
        }
      }
    }

    // pura pura loading
    await Future.delayed( Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AssessmentResultScreen(
          physicalDistress: widget.physicalDistress,
          stressLevel: widget.stressLevel,
          goal: widget.goal,
          gender: widget.gender,
          age: widget.age,
          moodValue: widget.moodValue,
          stressLevelAnswer: widget.stressLevelAnswer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color:  Color(0xFF4F3422),
          image:  DecorationImage(
            image: AssetImage('assets/Loading-Screen-Progress.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  'Compiling Data...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Please wait... We’re calculating the data based on your assessment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
