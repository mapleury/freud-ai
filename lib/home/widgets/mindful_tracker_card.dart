import 'package:flutter/material.dart';

class MindfulTrackerCard extends StatelessWidget {
  final IconData? icon;
  final String? iconImage;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final Widget? middle;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const MindfulTrackerCard({
    super.key,
    this.icon,
    this.iconImage,
    required this.title,
    this.subtitle,
    this.middle,
    this.trailing,
    this.iconColor,
    required this.backgroundColor,
    this.onPressed,
  });

  Widget buildIcon() {
    if (iconImage != null) {
      return Image.asset(iconImage!, width: 32, height: 32);
    }
    if (icon != null) {
      return Icon(icon, size: 26, color: iconColor);
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: buildIcon(),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4F3422),
                            ),
                          ),
        
                          if (middle != null) ...[SizedBox(height: 6), middle!],
        
                          if (subtitle != null) ...[
                            SizedBox(height: 6),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                color: Color(0xFF85807B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
        
                if (trailing != null)
                  Align(alignment: Alignment.center, child: trailing!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
