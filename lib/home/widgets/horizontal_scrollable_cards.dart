import 'package:flutter/material.dart';

class HorizontalScrollableCards extends StatefulWidget {
  final List<Widget> cards;
  final double? height;
  final bool showDots;

  const HorizontalScrollableCards({
    super.key,
    required this.cards,
    this.height,
    this.showDots = true,
  });

  @override
  State<HorizontalScrollableCards> createState() => _HorizontalScrollableCardsState();
}

class _HorizontalScrollableCardsState extends State<HorizontalScrollableCards> {
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double itemWidth = 160 + 12;
      int index = (offset / itemWidth).round();

      if (index != currentIndex && index < widget.cards.length) {
        setState(() => currentIndex = index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height ?? 196,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            clipBehavior: Clip.none,
            itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 12),
                child: widget.cards[index],
              );
            },
          ),
        ),

        if (widget.showDots) ...[
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.cards.length,
              (i) => AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == i
                      ? Color(0xFF4F3422)
                      : Color(0xFF4F3422).withValues(alpha: .5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
