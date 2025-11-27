import 'dart:typed_data';
import 'dart:math';

class BrightnessMetrics {
  final double average; 
  final double variance; // brightness variance
  final double mouthAvg;
  final double eyeAvg;

  BrightnessMetrics({
    required this.average,
    required this.variance,
    required this.mouthAvg,
    required this.eyeAvg,
  });
}

/// Analyze grayscale pixels for overall brightness, variance, and region brightness (eyes & mouth)
class BrightnessAnalyzer {
  /// Compute metrics. gray length must be width*height
  static BrightnessMetrics analyze(Uint8List gray, int width, int height) {
    final int n = gray.length;
    if (n == 0) {
      return BrightnessMetrics(average: 0, variance: 0, mouthAvg: 0, eyeAvg: 0);
    }

    // overall mean & variance
    double sum = 0;
    for (int i = 0; i < n; i++) sum += gray[i];
    final double mean = sum / n;

    double sqSum = 0;
    for (int i = 0; i < n; i++) {
      final double d = gray[i] - mean;
      sqSum += d * d;
    }
    final double variance = sqSum / n;

    // define regions
    final int eyeTop = (height * 0.12).floor();
    final int eyeBottom = (height * 0.35).floor();
    final int mouthTop = (height * 0.55).floor();

    double eyeSum = 0;
    int eyeCount = 0;
    for (int r = eyeTop; r < eyeBottom; r++) {
      final int rowStart = r * width;
      for (int c = (width * 0.2).floor(); c < (width * 0.8).floor(); c++) {
        eyeSum += gray[rowStart + c];
        eyeCount++;
      }
    }
    final double eyeAvg = eyeCount > 0 ? eyeSum / eyeCount : mean;

    double mouthSum = 0;
    int mouthCount = 0;
    for (int r = mouthTop; r < height; r++) {
      final int rowStart = r * width;
      for (int c = (width * 0.15).floor(); c < (width * 0.85).floor(); c++) {
        mouthSum += gray[rowStart + c];
        mouthCount++;
      }
    }
    final double mouthAvg = mouthCount > 0 ? mouthSum / mouthCount : mean;

    return BrightnessMetrics(
      average: mean,
      variance: variance,
      mouthAvg: mouthAvg,
      eyeAvg: eyeAvg,
    );
  }
}
