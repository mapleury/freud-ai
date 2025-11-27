import 'package:flutter/material.dart';

class EmojiPicker extends StatelessWidget {
  final List<String> emojis = ['😄', '😐', '😢', '😡', '😰', '🤯', '😭', '🧘'];
  final String selected;
  final void Function(String) onSelect;

  EmojiPicker({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: emojis.map((e) {
        return GestureDetector(
          onTap: () => onSelect(e),
          child: Text(
            e,
            style: TextStyle(
              fontSize: 32,
              color: e == selected ? Colors.blue : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
