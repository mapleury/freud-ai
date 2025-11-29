import 'dart:math' as math;
import 'package:final_project/home/home_screen.dart';
import 'package:final_project/stress/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'expression_camera_page.dart';

class StressLevelPage extends StatefulWidget {
  const StressLevelPage({super.key});

  @override
  State<StressLevelPage> createState() => _StressLevelPageState();
}

class _StressLevelPageState extends State<StressLevelPage>
    with TickerProviderStateMixin {
  double stressValue = 0.5;

  final Color brown = const Color(0xFF4F3422);

  late List<AnimationController> controllers;
  late List<Animation<double>> scaleAnimations;
  late List<Animation<double>> opacityAnimations;
  late List<Animation<double>> rotationAnimations;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      5,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 240),
      ),
    );

    scaleAnimations = controllers
        .map(
          (c) => Tween<double>(
            begin: 1.0,
            end: 1.33,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutBack)),
        )
        .toList();

    opacityAnimations = controllers
        .map(
          (c) => Tween<double>(
            begin: 0.4,
            end: 1.0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();

    rotationAnimations = controllers
        .map(
          (c) => Tween<double>(
            begin: 0.0,
            end: 0.08,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();

    Future.delayed(const Duration(milliseconds: 120), () {
      controllers[selectedLevel - 1].forward();
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  int get selectedLevel => ((stressValue * 4) + 1).round().clamp(1, 5);

  String get levelText {
    switch (selectedLevel) {
      case 1:
        return 'Low';
      case 2:
        return 'Mild';
      case 3:
        return 'Moderate';
      case 4:
        return 'High';
      case 5:
        return 'Severe';
      default:
        return 'Moderate';
    }
  }

  void _selectLevel(int level) {
    final newValue = (level - 1) / 4;

    setState(() {
      stressValue = newValue;
    });

    HapticFeedback.mediumImpact();

    for (var c in controllers) {
      c.reverse();
    }

    controllers[level - 1].forward();
  }

  void _onSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          stressLevel: selectedLevel,
          onGotIt: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          ),
        ),
      ),
    );
  }

  void _onRecord() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExpressionCameraPage(stressLevel: selectedLevel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BACK BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/brown-back-button.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // TITLE
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  "What's your stress level today?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: brown,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 10),

              // PICKER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final number = index + 1;

                  return GestureDetector(
                    onTap: () => _selectLevel(number),
                    child: AnimatedBuilder(
                      animation: controllers[index],
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: rotationAnimations[index].value,
                          child: Transform.scale(
                            scale: scaleAnimations[index].value,
                            child: Opacity(
                              opacity: opacityAnimations[index].value,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: number == selectedLevel
                                      ? brown
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: number == selectedLevel
                                        ? brown
                                        : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                  boxShadow: number == selectedLevel
                                      ? [
                                          BoxShadow(
                                            color: brown.withOpacity(0.3),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Text(
                                  number.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: number == selectedLevel
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              // LEVEL TEXT
              Column(
                children: [
                  Text(
                    selectedLevel.toString(),
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: brown,
                    ),
                  ),
                  Text(
                    levelText,
                    style: TextStyle(
                      fontSize: 18,
                      color: brown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // BUTTONS
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 28.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: _onSkip,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(
                          "Skip Record Expression",
                          style: TextStyle(
                            color: brown,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _onRecord,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          "Record Stress Expression →",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
