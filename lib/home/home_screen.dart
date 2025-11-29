import 'package:final_project/article/article_page.dart';
import 'package:final_project/article/article_service.dart';
import 'package:final_project/assessment/assesment_result.dart';
import 'package:final_project/assessment/mental_health_assesment_score.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:final_project/chatbot/chat_screen.dart';
import 'package:final_project/home/widgets/bottom_nav.dart';
import 'package:final_project/home/widgets/floating_button_on_image.dart';
import 'package:final_project/home/widgets/header_section.dart';
import 'package:final_project/home/widgets/horizontal_card.dart';
import 'package:final_project/home/widgets/horizontal_scrollable_cards.dart';
import 'package:final_project/home/widgets/mindful_resources_card.dart';
import 'package:final_project/home/widgets/mindful_tracker_card.dart';
import 'package:final_project/home/widgets/title_row.dart';
import 'package:final_project/journal/journal_screen.dart';
import 'package:final_project/mindful-hours/mindful_screen.dart';
import 'package:final_project/mood-tracker/calendar_mood_page.dart';
import 'package:final_project/stress/stress_level_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    // TODO: nanti route ke screen sesuai index bottom nav
  }

  String get username {
    final email = user?.email ?? "";
    if (email.contains('@')) {
      return email.split('@')[0];
    }
    return email;
  }

  final List<Article> articles = ArticleService.sampleArticles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F2),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // Header with username greeting
              HeaderSection(username: username),
              const SizedBox(height: 12),
              // Sign out button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOutAndGoToLogin(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  child: const Text("Sign Out"),
                ),
              ),
              const SizedBox(height: 20),

              // Mental Health Metrics
              TitleRow(
                title: 'Mental Health Metrics',
                trailing: const Icon(Icons.more_vert),
              ),
              HorizontalScrollableCards(
                showDots: true,
                cards: [
                  HorizontalCard(
                    image: 'assets/freud_score_image.png',
                    title: 'Freud Score',
                    icon: Icons.favorite,
                    backgroundColor: const Color(0xFF9BB167),
                    boxShadow: const BoxShadow(
                      color: Color(0xFF9BB167),
                      blurRadius: 8,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssessmentResultView(
                            physicalDistress: true,
                            stressLevel: 2,
                          ),
                        ),
                      );
                    },
                  ),
                  HorizontalCard(
                    image: 'assets/mood_image.png',
                    title: 'Mood',
                    icon: Icons.sentiment_dissatisfied_outlined,
                    backgroundColor: const Color(0xFFED7E1C),
                    boxShadow: const BoxShadow(
                      color: Color(0xFFED7E1C),
                      blurRadius: 8,
                    ),
                  ),
                  HorizontalCard(
                    image: 'assets/freud_score_image.png',
                    title: 'Stress Level',
                    icon: Icons.energy_savings_leaf,
                    backgroundColor: const Color(0xFFA694F5),
                    boxShadow: const BoxShadow(
                      color: Color(0xFFA694F5),
                      blurRadius: 8,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StressLevelPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // Mindful Tracker Section
              const SizedBox(height: 16),
              TitleRow(
                title: 'Mindful Tracker',
                trailing: const Icon(Icons.more_vert),
              ),
              Column(
                children: [
                  MindfulTrackerCard(
                    icon: Icons.access_time_filled,
                    title: 'Mindful Hours',
                    subtitle: '2.5/8h Today',
                    trailing: Image.asset('assets/mindful1.png'),
                    iconColor: const Color(0xFF9BB167),
                    backgroundColor: const Color(0xFF9BB167).withOpacity(0.1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MindfulHoursScreen(),
                        ),
                      );
                    },
                  ),
                  MindfulTrackerCard(
                    iconImage: 'icons/hospital_bed.png',
                    title: 'Sleep Quality',
                    subtitle: 'Insomniac (~2h Avg)',
                    trailing: Image.asset('assets/mindful2.png'),
                    backgroundColor: const Color(0xFFC2B1FF).withOpacity(0.1),
                  ),
                  MindfulTrackerCard(
                    iconImage: 'icons/journal_plus.png',
                    title: 'Mindful Journal',
                    subtitle: '64 Day Streak',
                    trailing: Image.asset('assets/mindful3.png'),
                    backgroundColor: const Color(0xFFED7E1C).withOpacity(0.1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JournalScreen(),
                        ),
                      );
                    },
                  ),
                  MindfulTrackerCard(
                    iconImage: 'icons/head_heart.png',
                    title: 'Stress Level',
                    subtitle: '64 Day Streak',
                    backgroundColor: const Color(0xFFFFBD19).withOpacity(0.1),
                    middle: Row(
                      children: [
                        bar(const Color(0xFFFFBD19)),
                        bar(const Color(0xFFFFBD19)),
                        bar(const Color(0xFFFFBD19)),
                        bar(Colors.grey.shade300),
                        bar(Colors.grey.shade300),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StressLevelPage(),
                        ),
                      );
                    },
                  ),
                  MindfulTrackerCard(
                    icon: Icons.sentiment_neutral_sharp,
                    iconColor: const Color(0xFF926247),
                    title: 'Mood Tracker',
                    backgroundColor: const Color(0xFF926247).withOpacity(0.1),
                    middle: Row(children: moodRow()),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarMoodPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // AI Chatbot Section
              const SizedBox(height: 16),
              TitleRow(
                title: 'AI Therapy Chatbot',
                trailing: const Icon(Icons.settings),
              ),
              FloatingButtonOnImage(
                image: 'assets/ai_banner.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),

              // Mindful Resources Section
              const SizedBox(height: 46),
              TitleRow(
                title: 'Mindful Resources',
                // Removed the trailing "See All" navigation completely
              ),

              HorizontalScrollableCards(
                height: 230,
                showDots: false,
                cards: articles.map((article) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: MindfulResourcesCard(article: article),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // Helpers
  Widget bar(Color color) {
    return Container(
      height: 6,
      width: 40,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  List<Widget> moodRow() {
    return [
      tag('Sad', const Color(0xFFED7E1C)),
      Image.asset('icons/arrow_forward.png'),
      tag('Happy', const Color(0xFF9BB167)),
      Image.asset('icons/arrow_forward.png'),
      tag('Neutral', const Color(0xFF926247)),
    ];
  }

  Widget tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
