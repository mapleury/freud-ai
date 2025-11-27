import 'dart:typed_data';
import 'dart:math';

class MotionRegionResult {
  final double overallMotion; // 0..1
  final double mouthMotion; // 0..1
  final double eyeMotion; // 0..1

  MotionRegionResult({
    required this.overallMotion,
    required this.mouthMotion,
    required this.eyeMotion,
  });
}

/// Simple frame differencer. Compare previous and current grayscale frames.
/// Motion score = fraction of pixels that changed more than a threshold.
/// Also computes motion for rough eye and mouth regions.
class MotionDetector {
  Uint8List? _prevFrame;

  /// Call to compute motion. width*height == frames length.
  MotionRegionResult compute(Uint8List current, int width, int height) {
    if (_prevFrame == null || _prevFrame!.length != current.length) {
      _prevFrame = Uint8List.fromList(current);
      return MotionRegionResult(overallMotion: 0.0, mouthMotion: 0.0, eyeMotion: 0.0);
    }

    final int len = current.length;
    int changed = 0;
    int changedMouth = 0;
    int changedEye = 0;

    // thresholds
    const int diffThreshold = 12; // small movement
    final int mouthHeightPx =  (height / 6).floor(); // bottom region
    final int mouthTop = (height * 0.55).floor(); // start around lower half
    final int eyeBottom = (height * 0.35).floor();
    final int eyeTop = (height * 0.12).floor();

    for (int r = 0; r < height; r++) {
      final int rowStart = r * width;
      for (int c = 0; c < width; c++) {
        final int idx = rowStart + c;
        final int a = _prevFrame![idx];
        final int b = current[idx];
        final int d = (a - b).abs();
        if (d > diffThreshold) {
          changed++;
          if (r >= mouthTop) changedMouth++;
          if (r >= eyeTop && r <= eyeBottom) changedEye++;
        }
      }
    }

    final double overallMotion = changed / len;
    final int mouthRegionPixels = width * (height - mouthTop);
    final int eyeRegionPixels = width * (eyeBottom - eyeTop);

    final double mouthMotion = mouthRegionPixels > 0 ? (changedMouth / mouthRegionPixels) : 0.0;
    final double eyeMotion = eyeRegionPixels > 0 ? (changedEye / eyeRegionPixels) : 0.0;

    // store current as prev
    _prevFrame = Uint8List.fromList(current);

    // clamp
    double clamp01(double v) => max(0.0, min(1.0, v));

    return MotionRegionResult(
      overallMotion: clamp01(overallMotion),
      mouthMotion: clamp01(mouthMotion),
      eyeMotion: clamp01(eyeMotion),
    );
  }

  void reset() => _prevFrame = null;
}
