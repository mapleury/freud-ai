class MessageModel {
final String id;
final String text;
final String sender;
final DateTime timestamp;
final String? emotion;


MessageModel({
required this.id,
required this.text,
required this.sender,
required this.timestamp,
this.emotion,
});


Map<String, dynamic> toMap() => {
'text': text,
'sender': sender,
'timestamp': timestamp.toIso8601String(),
'emotion': emotion,
};


static MessageModel fromMap(String id, Map<String, dynamic> m) => MessageModel(
id: id,
text: m['text'] ?? '',
sender: m['sender'] ?? 'user',
timestamp: DateTime.parse(m['timestamp']),
emotion: m['emotion'],
);
}