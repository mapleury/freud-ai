import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// cek siapa yg lagi login
  User? get currentUser => _auth.currentUser;

  /// stream kalau state ganti
  Stream<User?> get userStream => _auth.authStateChanges();

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

  Future<User?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await createUserDoc(cred.user!.uid, email);
    return cred.user;
  }

  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Ensure user doc exists buat old users juga
    await createUserDoc(cred.user!.uid, email);
    return cred.user;
  }

  /// Sign out and navigate to login
  Future<void> signOutAndGoToLogin(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
