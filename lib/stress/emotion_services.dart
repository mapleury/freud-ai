import 'package:cloud_firestore/cloud_firestore.dart';

class EmotionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveEmotionData({
    required int stressLevel,
    required String emotion,
  }) async {
    await _db.collection('responses').add({
      'stress': stressLevel,
      'emotion': emotion,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
