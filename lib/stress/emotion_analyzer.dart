class EmotionAnalyzer {
  static final List<String> _emotions = [
    "Neutral",
    "Happy-ish",
    "Tired",
    "Annoyed",
    "Focused",
    "Trying not to scream",
    "Blank stare"
  ];

  static String estimateManualEmotion() {
    _emotions.shuffle();
    return _emotions.first;
  }
}


