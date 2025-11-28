import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BreatheScreen extends StatefulWidget {
  const BreatheScreen({super.key});

  @override
  State<BreatheScreen> createState() => _BreatheScreenState();
}

class _BreatheScreenState extends State<BreatheScreen> {
  final player = AudioPlayer();

  bool isPlaying = false;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.onDurationChanged.listen((duration) {
      setState(() => totalDuration = duration);
    });

    player.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> toggleSound() async {
    if (!isPlaying) {
      await player.play(AssetSource('chirping.mp3'));
    } else {
      await player.pause();
    }
    setState(() => isPlaying = !isPlaying);
  }

  String formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (totalDuration.inMilliseconds > 0) {
      progress = currentPosition.inMilliseconds / totalDuration.inMilliseconds;
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/breathe.gif', fit: BoxFit.cover),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: toggleSound,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sound: Chirping Birds',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(currentPosition),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            formatTime(totalDuration),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.15,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          children: [
      
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),

                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0, 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              player.seek(Duration.zero);
                              player.pause();
                              setState(() {
                                isPlaying = false;
                                currentPosition = Duration.zero;
                              });
                            },
                          ),

                          const SizedBox(width: 16),

                          GestureDetector(
                            onTap: toggleSound,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 40,
                                color: Color(0xFFED7E1C),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          IconButton(
                            icon: const Icon(
                              Icons.restart_alt,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await player.stop();
                              await player.play(AssetSource('chirping.mp3'));
                              setState(() => isPlaying = true);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
