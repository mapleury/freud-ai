import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Question3Age extends StatefulWidget {
  @override
  _Question3AgeState createState() => _Question3AgeState();
}

class _Question3AgeState extends State<Question3Age> {
  final int minAge = 11;
  final int maxAge = 70;

  late final FixedExtentScrollController controller;

  int selectedAge = 20;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController(
      initialItem: selectedAge - minAge, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4F2),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assessment",
                    style: TextStyle(
                      fontFamily: "Urbanist",
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
                      "3 of 7",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 14,
                        color: Color(0xFF4B2E23),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "What’s your age?",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B2E23),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Spacer(),

            SizedBox(
              height: 300,
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 70,
                physics: FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  final age = minAge + index;
                  if (age <= maxAge) {
                    setState(() {
                      selectedAge = age;
                    });
                  }
                  HapticFeedback.selectionClick();
                },
                perspective: 0.002,
                renderChildrenOutsideViewport: false,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: (maxAge - minAge) + 1,
                  builder: (context, index) {
                    final age = minAge + index;
                    final bool isSelected = age == selectedAge;

                    return AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 250),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: isSelected ? 60 : 35,
                        color: isSelected
                            ? Color(0xFF4B2E23)
                            : Color(0xFF4B2E23).withOpacity(0.35),
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                      child: Center(child: Text(age.toString())),
                    );
                  },
                ),
              ),
            ),

            Spacer(),

            Padding(
              padding: EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/q4");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4B2E23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Continue →",
                    style: TextStyle(
                      fontFamily: "Urbanist",
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
