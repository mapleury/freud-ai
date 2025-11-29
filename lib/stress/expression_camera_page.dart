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

  bool _emotionSent = false;
  int _frameCounter = 0;

  final MotionDetector _motionDetector = MotionDetector();
  String? _finalEmotion;

  final Color brown = const Color(0xFF4F3422);

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
    } catch (e) {
      // ignore for now
    }
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

      if (!_emotionSent) {
        _emotionSent = true;
        _finalEmotion = emotion;

        if (widget.onEmotionDetected != null) {
          widget.onEmotionDetected!(emotion);
        }

        try {
          await _controller?.stopImageStream();
        } catch (_) {}

        if (mounted) setState(() {});
      }
    } catch (_) {
      // ignore frame errors
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

    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),

        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          title: const Text(
            'Expression Recording',
            style: TextStyle(color: Color(0xFF4F3422)),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "assets/brown-back-button.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      _controller == null ||
                          !_controller!.value.isInitialized ||
                          finalEmotion != null
                      ? Container(
                          color: Colors.black,
                          child: Center(
                            child: finalEmotion == null
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Emotion Captured',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        )
                      : CameraPreview(_controller!),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0ECE9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Stress level: ${widget.stressLevel}',
                      style: TextStyle(fontSize: 16, color: brown),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      finalEmotion == null
                          ? 'Detecting...'
                          : 'Emotion: $finalEmotion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brown,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      finalEmotion == null
                          ? 'Hold still for a moment'
                          : 'Saved successfully',
                      style: TextStyle(fontSize: 13, color: brown),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
