class AssessmentModel {
  final String uid;
  final bool physicalDistress;
  final int stressLevel;
  final int score;
  final DateTime timestamp;

  // dapet dari jawaban si user
  final String? goal;
  final String? gender;
  final int? age;
  final double? moodValue;
  final double? stressLevelAnswer;

  AssessmentModel({
    required this.uid,
    required this.physicalDistress,
    required this.stressLevel,
    required this.score,
    required this.timestamp,
    this.goal,
    this.gender,
    this.age,
    this.moodValue,
    this.stressLevelAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'physicalDistress': physicalDistress,
      'stressLevel': stressLevel,
      'score': score,
      'timestamp': timestamp.toUtc(),
      'goal': goal,
      'gender': gender,
      'age': age,
      'mood': moodValue,
      'stress': stressLevelAnswer,
    };
  }

  static Future<AssessmentModel?> fromMap(Map<String, dynamic> data) async {}
}
