import 'package:flutter/material.dart';
import 'dart:math' as math;

class Question4Mood extends StatefulWidget {
  @override
  _Question4MoodState createState() => _Question4MoodState();
}

class _Question4MoodState extends State<Question4Mood> {
  double moodValue = 0.5; // 0 = sad, 1 = happy

  String getMoodText() {
    if (moodValue < 0.33) return "I feel sad.";
    else if (moodValue < 0.67) return "I feel neutral.";
    else return "I feel happy.";
  }

  IconData getMoodIcon() {
    if (moodValue < 0.33) return Icons.sentiment_dissatisfied_outlined;
    else if (moodValue < 0.67) return Icons.sentiment_neutral_outlined;
    else return Icons.sentiment_satisfied_outlined;
  }

  Color getMoodColor() {
    if (moodValue < 0.33) return Colors.orange;
    else if (moodValue < 0.67) return const Color(0xFFFFD700);
    else return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Custom header with 'C' back, title, and progress
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Circular 'C' back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Assessment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '1 of 8',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.brown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Question text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                "How would you describe your mood?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            // Selected mood display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      getMoodText(),
                      key: ValueKey(moodValue),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF8D6E63),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      getMoodIcon(),
                      key: ValueKey(moodValue),
                      size: 80,
                      color: getMoodColor(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Mood gauge
            SizedBox(
              height: 150,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double centerX = constraints.maxWidth / 2;
                  final double radius = 60.0;
                  final double centerY = 70.0;
                  final double trackWidth = 2 * radius;
                  final double leftX = centerX - radius;
                  final double knobLeft = leftX + moodValue * trackWidth - 10;
                  final double baselineY = centerY;
                  return GestureDetector(
                    onPanUpdate: (details) {
                      final double newValue = ((details.localPosition.dx - leftX) / trackWidth).clamp(0.0, 1.0);
                      setState(() => moodValue = newValue);
                    },
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(constraints.maxWidth, 150),
                          painter: MoodGaugePainter(centerX: centerX, centerY: centerY, radius: radius),
                        ),
                        // Sad small face
                        Positioned(
                          left: centerX - radius + 10,
                          top: baselineY - 30,
                          child: Icon(
                            Icons.sentiment_dissatisfied_outlined,
                            size: 28,
                            color: Colors.orange,
                          ),
                        ),
                        // Neutral small face
                        Positioned(
                          left: centerX - 14,
                          top: baselineY - 35, // Slightly higher to simulate arc position
                          child: Icon(
                            Icons.sentiment_neutral_outlined,
                            size: 28,
                            color: const Color(0xFFFFD700),
                          ),
                        ),
                        // Happy small face
                        Positioned(
                          left: centerX + radius - 14,
                          top: baselineY - 30,
                          child: Icon(
                            Icons.sentiment_satisfied_outlined,
                            size: 28,
                            color: Colors.green,
                          ),
                        ),
                        // Pointer knob
                        Positioned(
                          left: knobLeft,
                          top: baselineY - 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            // Continue button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/q5"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Continue →",
                    style: TextStyle(
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

class MoodGaugePainter extends CustomPainter {
  final double centerX;
  final double centerY;
  final double radius;

  MoodGaugePainter({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double sweepPerSegment = math.pi / 3;

    final Paint sadPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    final Paint neutralPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    final Paint happyPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    // Sad arc: start at pi, sweep pi/3 clockwise
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi,
      sweepPerSegment,
      false,
      sadPaint,
    );

    // Neutral arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi + sweepPerSegment,
      sweepPerSegment,
      false,
      neutralPaint,
    );

    // Happy arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi + 2 * sweepPerSegment,
      sweepPerSegment,
      false,
      happyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}