import 'dart:math';
import 'brightness_analyzer.dart';
import 'motion_detector.dart';

class EmotionEngine {
  /// core heuristic combining motion and brightness signals into a human-readable label.
  /// This is intentionally simple, tweak thresholds to taste.
  static String decideEmotion({
    required MotionRegionResult motion,
    required BrightnessMetrics brightness,
  }) {
    // normalize some signals
    final double motionScore = motion.overallMotion; // 0..1
    final double mouthMotion = motion.mouthMotion; // 0..1
    final double eyeMotion = motion.eyeMotion; // 0..1
    final double mouthBrightness = brightness.mouthAvg / 255.0; // 0..1
    final double eyeBrightness = brightness.eyeAvg / 255.0; // 0..1
    final double varianceNorm = min(1.0, brightness.variance / 4000.0); // rough normalization

    // Heuristics (balanced mode)
    // smiling: mouth brightness high (teeth) and mouth motion moderate
    final bool smiling = (mouthBrightness > 0.6 && mouthMotion > 0.01 && varianceNorm > 0.02);

    // talking / animated: mouth motion high
    final bool talking = mouthMotion > 0.06 && mouthBrightness < 0.7;

    // annoyed: high overall motion but low mouth brightness (fast gestures, frown)
    final bool annoyed = motionScore > 0.06 && mouthBrightness < 0.45 && varianceNorm > 0.03;

    // tired/sad: low motion, low brightness
    final bool tired = motionScore < 0.01 && brightness.average < 80;

    // focused/neutral: low motion, moderate brightness and low variance
    final bool focused = motionScore < 0.02 && varianceNorm < 0.02 && brightness.average > 90;

    // surprised: quick eye motion and higher eye brightness
    final bool surprised = eyeMotion > 0.05 && eyeBrightness > 0.6 && varianceNorm > 0.04;

    // Decide with precedence
    if (smiling) return "happy-ish";
    if (surprised) return "surprised";
    if (annoyed) return "annoyed";
    if (talking) return "talking/animated";
    if (tired) return "tired";
    if (focused) return "focused";
    // fallback
    if (motionScore > 0.04) return "active";
    return "neutral";
  }
}
