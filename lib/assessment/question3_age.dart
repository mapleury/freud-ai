import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Question3Age extends StatefulWidget {
  @override
  _Question3AgeState createState() => _Question3AgeState();
}

class _Question3AgeState extends State<Question3Age> {
  FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 2); // Start at 18 (index 2: 16+2=18)

  int selectedAge = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background to match the screenshot
      body: SafeArea(
        child: Column(
          children: [
            // Custom header with only back arrow
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.brown),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            // Question text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const Text(
                "What’s your age?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(), // Push the wheel to the center
            // Scrollable Age Picker (Wheel) - Centered vertically
            SizedBox(
              height: 250, // Slightly taller for better centering and interaction
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 70, // Larger items for better interactivity
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedAge = 16 + index;
                  });
                  // Add haptic feedback for more interactivity
                  HapticFeedback.selectionClick();
                },
                perspective: 0.002, // Slight 3D perspective for interactivity
                renderChildrenOutsideViewport: false,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final age = 16 + index;
                    if (age > 120) return null; // Extended upper limit to 120 for "no limits" feel

                    final isSelected = age == selectedAge;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.brown.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: isSelected ? 36 : 22,
                          color: isSelected ? Colors.brown : Colors.grey,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          shadows: isSelected
                              ? [
                                  const Shadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(child: Text(age.toString())),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Spacer(), // Balance the spacing for centering
            // Continue button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/q4");
                  },
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