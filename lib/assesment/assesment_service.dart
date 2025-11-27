import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/assesment/assesment_model.dart';

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
}
