import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const TitleRow({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
               fontFamily: 'Urbanist',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F3422),
            ),
          ),

          trailing ?? SizedBox(),
        ],
      ),
    );
  }
}
