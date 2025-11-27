import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'pixel_frame_converter.dart';
import 'motion_detector.dart';
import 'brightness_analyzer.dart';
import 'emotion_engine.dart';

class ExpressionCameraPage extends StatefulWidget {
  final int stressLevel;
  final void Function(String emotion)? onEmotionDetected;

  const ExpressionCameraPage({
    super.key,
    required this.stressLevel,
    this.onEmotionDetected,
  });

  @override
  State<ExpressionCameraPage> createState() => _ExpressionCameraPageState();
}

class _ExpressionCameraPageState extends State<ExpressionCameraPage> {
  CameraController? _controller;
  bool _processing = false;
  bool _isDisposed = false;

  // Only ONE result
  bool _emotionSent = false;

  // balanced frame skipping
  int _frameCounter = 0;

  final MotionDetector _motionDetector = MotionDetector();
  String? _finalEmotion;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      await _controller!.startImageStream(_onFrameAvailable);

      if (mounted) setState(() {});
    } catch (e) {}
  }

  void _onFrameAvailable(CameraImage image) async {
    if (_isDisposed || _emotionSent) return;

    _frameCounter++;
    if (_frameCounter % 2 != 0) return;

    if (_processing) return;
    _processing = true;

    try {
      final Uint8List gray = PixelFrameConverter.yPlaneToGray(image);
      final int width = image.width;
      final int height = image.height;

      final motion = _motionDetector.compute(gray, width, height);

      final brightness = BrightnessAnalyzer.analyze(gray, width, height);

      final String emotion = EmotionEngine.decideEmotion(
        motion: motion,
        brightness: brightness,
      );

      // ONLY ONCE
      if (!_emotionSent) {
        _emotionSent = true;
        _finalEmotion = emotion;

        // send to firebase through callback
        if (widget.onEmotionDetected != null) {
          widget.onEmotionDetected!(emotion);
        }

        // stop the camera stream
        try {
          await _controller?.stopImageStream();
        } catch (_) {}

        if (mounted) setState(() {});
      }
    } catch (_) {
    } finally {
      _processing = false;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final finalEmotion = _finalEmotion;

    return Scaffold(
      appBar: AppBar(title: const Text('Expression Recording')),
      body: Column(
        children: [
          Expanded(
            child: _controller == null ||
                    !_controller!.value.isInitialized ||
                    finalEmotion != null
                ? Container(
                    color: Colors.black,
                    child: Center(
                      child: finalEmotion == null
                          ? const CircularProgressIndicator()
                          : Text(
                              'Emotion Captured',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )
                : CameraPreview(_controller!),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Stress level: ${widget.stressLevel}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Text(
                  finalEmotion == null
                      ? 'Detecting...'
                      : 'Emotion: $finalEmotion',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  finalEmotion == null
                      ? 'Hold still for a moment'
                      : 'Saved successfully',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
