import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/journal/journal_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JournalService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference get _ref => _firestore.collection('journals');

  String get _uid => _auth.currentUser!.uid;

  Future<void> createEntry(JournalEntry entry) async {
    final data = entry.toMap();
    data['uid'] = _uid;
    await _ref.add(data);
  }

  Stream<List<JournalEntry>> getEntries() {
    return _ref.where('uid', isEqualTo: _uid).snapshots().map((snap) {
      final list = snap.docs
          .map(
            (doc) => JournalEntry.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      // sort manual karena Firestore ngambek
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return list;
    });
  }

  Future<void> updateEntry(JournalEntry entry) async {
    // cek dulu apakah yang update adalah pemilik
    final doc = await _ref.doc(entry.id).get();
    if (doc['uid'] != _uid) return;

    await _ref.doc(entry.id).update(entry.toMap());
  }

  Future<void> deleteEntry(String id) async {
    final doc = await _ref.doc(id).get();
    if (doc['uid'] != _uid) return;

    await _ref.doc(id).delete();
  }

  Future<List<JournalEntry>> getEntriesForDate(DateTime date) async {
    final snap = await _ref.where('uid', isEqualTo: _uid).get();

    final all = snap.docs
        .map(
          (d) => JournalEntry.fromMap(d.id, d.data() as Map<String, dynamic>),
        )
        .toList();

    return all.where((e) {
      return e.createdAt.year == date.year &&
          e.createdAt.month == date.month &&
          e.createdAt.day == date.day;
    }).toList();
  }
}
