import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'journal_service.dart';
import 'journal_entry.dart';
import 'read_journal_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),

      body: Column(
        children: [
          // HEADER
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
                    "My Journals",
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

          // LIST
          Expanded(
            child: StreamBuilder<List<JournalEntry>>(
              stream: JournalService().getEntries(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final entries = snapshot.data!;
                if (entries.isEmpty) {
                  return Center(
                    child: Text(
                      "No journals yet.",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  itemCount: entries.length,
                  itemBuilder: (context, i) {
                    final entry = entries[i];
                    return _journalCard(context, entry);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _journalCard(BuildContext context, JournalEntry entry) {
    final formattedDate = DateFormat(
      "dd MMM yyyy",
    ).format(entry.createdAt.toLocal());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ViewJournalScreen(entry: entry)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                entry.emoji.isNotEmpty
                    ? Image.asset(entry.emoji, width: 36, height: 36)
                    : const SizedBox(width: 36, height: 36),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _moodFromStress(entry.stressLevel),
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              entry.title.isNotEmpty
                  ? entry.title
                  : entry.content.length > 40
                  ? "${entry.content.substring(0, 40)}..."
                  : entry.content,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF433530),
              ),
            ),

            const SizedBox(height: 10),

            // Date
            Text(
              formattedDate,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _moodFromStress(int stress) {
    if (stress <= 30) return "Happy";
    if (stress <= 60) return "Neutral";
    return "Stressed";
  }
}
