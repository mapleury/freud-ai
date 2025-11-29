import 'dart:async';
import 'package:final_project/assessment/question1_goal.dart';
import 'package:final_project/mindful-hours/mindful_screen.dart';
import 'package:final_project/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:final_project/auth/login_page.dart';
import 'package:final_project/home/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  int _progress = 0;
  final AuthService _auth = AuthService();
  late Timer _timer;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward(); 

    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 25), (timer) async {
      if (_progress >= 100) {
        _timer.cancel();
        await _fadeOutAndNavigate();
      } else {
        setState(() => _progress++);
      }
    });
  }

  Future<void> _fadeOutAndNavigate() async {
    await _fadeController.reverse(); 
    final user = _auth.currentUser;

    Widget nextPage;

    if (user == null) {
      nextPage =  WelcomeScreen();
    } else {
      final firstTime = await _auth.isFirstTimeUser(user.uid);
      nextPage = firstTime ? WelcomeScreen() : HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => nextPage,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/Loading-Screen-Progress.gif',
              fit: BoxFit.cover,
            ),
            Center(
              child: Text(
                '$_progress%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
