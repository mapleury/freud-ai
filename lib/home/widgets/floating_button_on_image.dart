import 'package:flutter/material.dart';

class FloatingButtonOnImage extends StatelessWidget {
  final String image;

  const FloatingButtonOnImage({
    super.key, required this.image, required Null Function() onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          bottom: -30,
          child: Row(
            children: [
              _circleBtn(
                icon: Icons.add,
                color: Color(0xFF9BB167),
                onTap: () {},
              ),
              SizedBox(width: 12),
              _circleBtn(
                icon: Icons.settings,
                color: Color(0xFFED7E1C),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleBtn({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: .2),
              blurRadius: 12,
              spreadRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
