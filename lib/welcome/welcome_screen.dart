import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<String> pages = [
    "assets/welcome1.png",
    "assets/welcome2.png",
    "assets/welcome3.png",
    "assets/welcome4.png",
    "assets/welcome5.png",
  ];

  double progressBarBottomPadding = 300;
  double progressBarWidth = 140;
  double progressBarHeight = 7;


void nextPage() {
  if (currentPage < pages.length - 1) {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } else {
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}



  @override
  Widget build(BuildContext context) {
    double progress = (currentPage + 1) / pages.length;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (value) {
              setState(() => currentPage = value);
            },
            itemBuilder: (context, index) {
              return SizedBox.expand(
                child: Image.asset(pages[index], fit: BoxFit.cover),
              );
            },
          ),

          Positioned(
            bottom: progressBarBottomPadding,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: progressBarWidth,
                height: progressBarHeight,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    width: progressBarWidth * progress,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B3A2F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 55,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: nextPage,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B3A2F),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/arrow_right.png',
                      width: 26,
                      height: 26,
                      fit: BoxFit.contain,
                    ),
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




