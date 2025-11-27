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
    // this is random now, but you can replace it
    // with whatever custom logic you want.
    _emotions.shuffle();
    return _emotions.first;
  }
}


