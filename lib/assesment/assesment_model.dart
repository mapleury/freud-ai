class AssessmentModel {
  final String uid;
  final bool physicalDistress;
  final int stressLevel;
  final int score;
  final DateTime timestamp;

  AssessmentModel({
    required this.uid,
    required this.physicalDistress,
    required this.stressLevel,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'physicalDistress': physicalDistress,
      'stressLevel': stressLevel,
      'score': score,
      'timestamp': timestamp.toUtc(),
    };
  }
}
