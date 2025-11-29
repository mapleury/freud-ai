import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: Offset(0, -3),
            color: Colors.black.withValues(alpha: .05),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navItem(Icons.home, 0),
          navItem(Icons.search, 1),
          navItem(Icons.favorite, 2),
          navItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget navItem(IconData icon, int index) {
    bool active = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active
              ? Color(0xFF4F3422).withValues(alpha: .2)
              : Colors.transparent,
          shape: BoxShape.circle
        ),
        child: Icon(
          icon,
          size: 26,
          color: active ? Color(0xFF4F3422) : Colors.grey,
        ),
      ),
    );
  }
}
