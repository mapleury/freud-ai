import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> ensureSignedInAnonymously() async {
    final current = _auth.currentUser;
    if (current != null) return current;
    final res = await _auth.signInAnonymously();
    return res.user!;
  }

  Stream<List<MessageModel>> streamMessages() {
    return _firestore
        .collection('chats')
        .doc('default')
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => MessageModel.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Future<void> addMessage(MessageModel m) async {
    await _firestore
        .collection('chats')
        .doc('default')
        .collection('messages')
        .add(m.toMap());
  }
  
  Future<void> clearChat() async {
  final messagesCollection = _firestore.collection('chats').doc('default').collection('messages');
  final snapshots = await messagesCollection.get();
  for (final doc in snapshots.docs) {
    await doc.reference.delete();
  }
}

}
