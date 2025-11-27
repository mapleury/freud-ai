import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? currentUser() => _auth.currentUser;

  Future<bool> isFirstTimeUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return true;
    return doc.data()?['completedAssessment'] != true;
  }

  Future<void> createUserDoc(String uid, String email) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'completedAssessment': false,
      'createdAt': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> markAssessmentDone(String uid) async {
    await _db.collection('users').doc(uid).set({
      'completedAssessment': true,
    }, SetOptions(merge: true));
  }

  // SIGN UP
  Future<User?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await createUserDoc(cred.user!.uid, email);

    return cred.user;
  }

  // SIGN IN
  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Ensure doc exists even if old user
    await createUserDoc(cred.user!.uid, email);

    return cred.user;
  }

Future<void> signOutAndGoToLogin(BuildContext context) async {
  await _auth.signOut();

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (route) => false,
  );
}

  Stream<User?> get userStream => _auth.authStateChanges();
}
