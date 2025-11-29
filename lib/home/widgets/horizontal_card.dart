import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  final String image;
  final String title;
  final IconData icon;
  final BoxShadow boxShadow;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const HorizontalCard({
    super.key, required this.image, required this.title, required this.backgroundColor, required this.icon, required this.boxShadow, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160,
        height: 196,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [boxShadow],
          borderRadius: BorderRadius.circular(24)
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Image.asset(
                image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
