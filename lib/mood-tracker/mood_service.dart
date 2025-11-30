import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = 'moods';

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> setMood({required DateTime date, required String emoji}) async {
    final key = _dateKey(date);
    await _db
        .collection('users')
        .doc(_uid)
        .collection(collectionName)
        .doc(key)
        .set({
      'date': key,
      'emoji': emoji,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getMoodForDate(DateTime date) async {
    final key = _dateKey(date);
    final snap = await _db
        .collection('users')
        .doc(_uid)
        .collection(collectionName)
        .doc(key)
        .get();
    if (!snap.exists) return null;
    final data = snap.data();
    return data?['emoji'] as String?;
  }

  Future<Map<String, String>> getMoodsForDates(List<DateTime> dates) async {
    final Map<String, String> out = {};
    for (final d in dates) {
      final key = _dateKey(d);
      final snap = await _db
          .collection('users')
          .doc(_uid)
          .collection(collectionName)
          .doc(key)
          .get();
      if (snap.exists) {
        final data = snap.data();
        if (data != null && data['emoji'] is String) {
          out[key] = data['emoji'] as String;
        }
      }
    }
    return out;
  }

  Future<List<Map<String, dynamic>>> fetchAllMoods({int limit = 200}) async {
    final q = await _db
        .collection('users')
        .doc(_uid)
        .collection(collectionName)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return q.docs
        .map(
          (d) => {
            'date': d.data()['date'],
            'emoji': d.data()['emoji'],
            'timestamp': d.data()['timestamp'],
          },
        )
        .toList();
  }
}
