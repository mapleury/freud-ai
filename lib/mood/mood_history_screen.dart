import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodHistoryScreen extends StatelessWidget {
  const MoodHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String day = DateFormat('d').format(DateTime.now());
    String month = DateFormat('MMM').format(DateTime.now()).toUpperCase();

    Widget moodCard(String moodTitle, String imgPath) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // kotak tanggal
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F3EE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8A7F75),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    day,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF4D3A2A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            // text bpm row
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // mood title
                  Text(
                    moodTitle,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4D3A2A),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.favorite, size: 17, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        "96bpm",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          color: const Color(0xFF8A7F75),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Icon(Icons.add, size: 17, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        "121sys",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          color: const Color(0xFF8A7F75),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // icon mood kanan
            Image.asset(imgPath, width: 45, height: 45, fit: BoxFit.contain),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                color: Color(0xFF4F3422),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 45,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/images/back_button.png',
                        width: 42,
                        height: 42,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 22,
                    bottom: 85,
                    child: Text(
                      "My Mood",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF704A33),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4F3422),
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.black54),
                ],
              ),
            ),

            const SizedBox(height: 15),

            moodCard("Overenjoyed", "assets/images/icon1.png"),
            moodCard("Overenjoyed", "assets/images/icon1.png"),
            moodCard("Overenjoyed", "assets/images/icon1.png"),
            moodCard("Overenjoyed", "assets/images/icon1.png"),
            moodCard("Overenjoyed", "assets/images/icon1.png"),
          ],
        ),
      ),
    );
  }
}
