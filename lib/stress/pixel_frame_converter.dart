// Converts CameraImage (YUV420) -> grayscale Uint8List (width * height)
import 'dart:typed_data';
import 'package:camera/camera.dart';

class PixelFrameConverter {
  /// Converts the Y plane into a contiguous grayscale buffer of size width*height.
  /// It reads rows using bytesPerRow because sometimes stride != width.
  static Uint8List yPlaneToGray(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final Plane yPlane = image.planes[0];

    final Uint8List yBytes = yPlane.bytes;
    final int bytesPerRow = yPlane.bytesPerRow;

    final Uint8List gray = Uint8List(width * height);
    int dst = 0;
    int srcRowStart = 0;

    // Each row has bytesPerRow but only first [width] bytes correspond to pixels.
    for (int row = 0; row < height; row++) {
      srcRowStart = row * bytesPerRow;
      final int end = srcRowStart + width;
      // copy width bytes from yBytes
      gray.setRange(dst, dst + width, yBytes, srcRowStart);
      dst += width;
    }
    return gray;
  }
}
