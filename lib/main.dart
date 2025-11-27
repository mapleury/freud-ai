import 'package:final_project/assesment/assesment_step1.dart';
import 'package:final_project/assesment/assesment_step2.dart';
import 'package:final_project/home/home_screen.dart';
import 'package:final_project/journal/create_journal_screen.dart';
import 'package:final_project/stress/stress_level_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Auth
import 'auth/login_page.dart';
import 'auth/sign_up_page.dart';

// Assessment

// Modules
import 'article/article_page.dart';
import 'mood-tracker/mood_history_page.dart';
import 'journal/journal_screen.dart';
import 'chatbot/chat_screen.dart';

// Services
import 'auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/',
      routes: {
        '/': (context) => RootRouter(), // decides where to send user
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),

        // Assessment flow
        '/assessment-step1': (context) => AssessmentStep1(),
        '/assessment-step2': (context) => AssessmentStep2(),

        // Home
        '/home': (context) => HomePage(),

        // Module pages
        '/articles': (context) => ArticlesPage(),
        '/mood': (context) => MoodHistoryPage(),
        '/journal': (context) => JournalScreen(),
        '/stress': (context) => StressLevelPage(),
        '/chatbot': (context) => ChatScreen(),
      },
    );
  }
}

/// This decides where the user goes at startup:
/// - If no user → login
/// - If user is signed in but first-time signup → assessment
/// - If user already existed → home
class RootRouter extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return LoginPage();
        }

        // CEK FIRESTORE: SUDAH SELESAI ASSESSMENT ATAU BELUM?
        return FutureBuilder(
          future: auth.isFirstTimeUser(user.uid),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final firstTime = snap.data!;

            if (firstTime) {
              return AssessmentStep1();
            }

            return HomePage();
          },
        );
      },
    );
  }
}
