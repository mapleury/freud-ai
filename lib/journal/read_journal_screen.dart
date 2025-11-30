import 'package:flutter/material.dart';
import 'journal_entry.dart';
import 'package:intl/intl.dart';

class ViewJournalScreen extends StatelessWidget {
  final JournalEntry entry;

  const ViewJournalScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy – HH:mm').format(entry.createdAt.toLocal());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            height: 200,
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
                      'assets/back_button.png',
                      width: 42,
                      height: 42,
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  bottom: 40,
                  child: Text(
                    "View Journal",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji
                  if (entry.emoji.isNotEmpty)
                    ClipOval(
                      child: Image.asset(
                        entry.emoji,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    entry.title,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF736B66),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9B918B),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    entry.content,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 17,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF736B66),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Stress Level: ${entry.stressLevel}",
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF736B66),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: entry.stressLevel / 100,
                    color: const Color(0xFF4F3422),
                    backgroundColor: const Color(0xFFD9CFC9),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
