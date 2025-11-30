import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String title;
  final int total;
  final String mood;
  final Color moodColor;
  final IconData avatarIcon;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  const ChatCard({
    super.key,
    required this.title,
    required this.total,
    required this.mood,
    required this.moodColor,
    required this.avatarIcon,
    this.onTap,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(avatarIcon, color: Colors.brown[700]),
                ),
              ),
               SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                     SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey[600]),
                         SizedBox(width: 6),
                        Text('$total Total', style: TextStyle(color: Colors.grey[700])),
                         SizedBox(width: 14),
                        Icon(Icons.circle, size: 12, color: moodColor),
                         SizedBox(width: 6),
                        Text(mood, style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ),
               SizedBox(width: 8),
              GestureDetector(
                onTap: onTrailingTap,
                child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
