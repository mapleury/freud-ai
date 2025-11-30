import 'package:flutter/material.dart';

class EmotionPicker extends StatelessWidget {
  final List<String> emotionIcons = [
    'assets/icon4.png',
    'assets/icon5.png',
    'assets/icon6.png',
    'assets/icon7.png',
  ];

  final String selected;
  final void Function(String) onSelect;

  EmotionPicker({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,  
      spacing: 18,
      children: emotionIcons.map((path) {
        final bool isSelected = path == selected;

        return GestureDetector(
          onTap: () => onSelect(path),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: const Color(0xFF704A33), width: 3)
                  : null,
            ),
            child: Image.asset(path, width: 50, height: 50),
          ),
        );
      }).toList(),
    );
  }
}
