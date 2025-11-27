import 'package:final_project/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  String get username {
    final email = user?.email ?? "";
    if (email.contains('@')) {
      return email.split('@')[0];
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Hi $username!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
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

          ListTile(
            title: Text('Articles'),
            onTap: () => Navigator.pushNamed(context, '/articles'),
          ),
          ListTile(
            title: Text('Mood Tracker'),
            onTap: () => Navigator.pushNamed(context, '/mood'),
          ),
          ListTile(
            title: Text('Journal'),
            onTap: () => Navigator.pushNamed(context, '/journal'),
          ),
          ListTile(
            title: Text('Stress Level'),
            onTap: () => Navigator.pushNamed(context, '/stress'),
          ),
          ListTile(
            title: Text('Chatbot'),
            onTap: () => Navigator.pushNamed(context, '/chatbot'),
          ),
        ],
      ),
    );
  }
}
