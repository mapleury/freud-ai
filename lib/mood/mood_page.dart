import 'package:flutter/material.dart';

class MoodPage extends StatelessWidget {
  final Color bgColor;
  final String image;
  final VoidCallback onNext;
  final VoidCallback onSetMood;

  const MoodPage({
    super.key,
    required this.bgColor,
    required this.image,
    required this.onNext,
    required this.onSetMood,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // bg color
        Positioned.fill(child: Container(color: bgColor)),

        // atur ukuran gambar
        Align(
          alignment: Alignment(0, -0.3),
          child: SizedBox(
            width: 590,
            height: 590,
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),

        Positioned(
          bottom: 335,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "Slide to choose your mood »",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // button set mood
        Positioned(
          bottom: 90,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: onSetMood,
              child: Container(
                width: 360,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Set Mood",
                  style: TextStyle(
                    fontSize: 17,
                    color: const Color(0xFF4B3A2F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}