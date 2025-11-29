import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/assessment/assesment_model.dart';

class AssessmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String collection = 'assessments';

  Future<void> saveAssessment(AssessmentModel a) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("No logged-in user.");
    }

    final data = {
      ...a.toMap(),
      'uid': user.uid,
      'email': user.email,
      'timestamp': DateTime.now(),
    };

    await _db.collection(collection).add(data);
  }
  Future<AssessmentModel?> getLatestAssessment() async {
  final user = _auth.currentUser;
  if (user == null) return null;

  try {
    final snap = await _db
        .collection(collection)
        .where('uid', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;

    final data = snap.docs.first.data();

    // Untuk jaga-jaga Timestamp ke DateTime
    final ts = data['timestamp'];
    DateTime stamp;
    if (ts is Timestamp) {
      stamp = ts.toDate();
    } else {
      stamp = ts;
    }

    return AssessmentModel(
      uid: data['uid'],
      physicalDistress: data['physicalDistress'],
      stressLevel: data['stressLevel'],
      score: data['score'],
      timestamp: stamp,
      goal: data['goal'],
      gender: data['gender'],
      age: data['age'],
      moodValue: data['moodValue'],
      stressLevelAnswer: data['stressLevelAnswer'],
    );
  } catch (e) {
    print("ERROR GETTING LATEST ASSESSMENT: $e");
    return null;
  }
}


}
