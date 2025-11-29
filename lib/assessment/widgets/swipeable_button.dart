import 'package:flutter/material.dart';

class SwipeableButton extends StatefulWidget {
  final String text;
  final VoidCallback onComplete;

  const SwipeableButton({
    super.key, required this.text, required this.onComplete,
  });

  @override
  State<SwipeableButton> createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  double dragX = 0;
  final double initialOffset = 10;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 56;
    final double knobSize = 56;
    final double maxDrag = width - knobSize - initialOffset;

    return Container(
      width: width,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF4F3422),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 150),
            left: dragX + initialOffset,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  dragX += details.delta.dx;

                  if (dragX < 0) dragX = 0;
                  if (dragX > maxDrag) dragX = maxDrag;
                });
              },
              onHorizontalDragEnd: (_) {
                if (dragX >= maxDrag * 0.9) {
                  widget.onComplete();
                } else {
                  setState(() {
                    dragX = 0;
                  });
                }
              },
              child: Container(
                width: knobSize,
                height: knobSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.keyboard_double_arrow_right,
                    size: 32,
                    color: Color(0xFF4F3422),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
