class JournalEntry {
  final String id;
  final String uid;
  final String title;
  final String content;
  final String emoji;
  final int stressLevel;
  final DateTime createdAt;

  JournalEntry({
    required this.id,
    required this.uid,
    required this.title,
    required this.content,
    required this.emoji,
    required this.stressLevel,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'content': content,
      'emoji': emoji,
      'stressLevel': stressLevel,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(String id, Map<String, dynamic> map) {
    return JournalEntry(
      id: id,
      uid: map['uid'], // <----
      title: map['title'],
      content: map['content'],
      emoji: map['emoji'],
      stressLevel: map['stressLevel'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
