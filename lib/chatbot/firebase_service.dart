import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/chatbot/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService() {
    if (Firebase.apps.isEmpty) {
      throw Exception('Firebase not initialized yet!');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> ensureSignedInAnonymously() async {
    final current = _auth.currentUser;
    if (current != null) return current;
    final res = await _auth.signInAnonymously();
    return res.user!;
  }



  // Stream messages dgn timestamp
  Stream<List<MessageModel>> streamMessages() {
    return _firestore
        .collection('chats')
        .doc('default')
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snap) {
          return snap.docs.map((d) {
            final data = d.data();
            final ts = data['timestamp'];
            DateTime timestamp;
            if (ts is Timestamp) {
              timestamp = ts.toDate();
            } else if (ts is String) {
              timestamp = DateTime.tryParse(ts) ?? DateTime.now();
            } else {
              timestamp = DateTime.now();
            }
            return MessageModel(
              id: d.id,
              text: data['text'] ?? '',
              sender: data['sender'] ?? 'user',
              timestamp: timestamp,
              emotion: data['emotion'],
            );
          }).toList();
        });
  }

  Future<void> addMessage(MessageModel m) async {
    await _firestore
        .collection('chats')
        .doc('default')
        .collection('messages')
        .add(m.toMap());
  }

  Future<void> clearChat() async {
    final messagesCollection = _firestore
        .collection('chats')
        .doc('default')
        .collection('messages');
    final snapshots = await messagesCollection.get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
