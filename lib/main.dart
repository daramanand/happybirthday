import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  const BirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy Birthday',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF5F9E),
              Color(0xFFFF8A65),
              Color(0xFFFFD54F),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: 30,
                left: 25,
                child: Text(
                  '🎈',
                  style: TextStyle(fontSize: 65),
                ),
              ),

              const Positioned(
                top: 80,
                right: 25,
                child: Text(
                  '🎉',
                  style: TextStyle(fontSize: 60),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '🎂',
                        style: TextStyle(
                          fontSize: 130,
                        ),
                      )
                          .animate()
                          .scale(
                            duration: 1200.ms,
                            begin: const Offset(0.3, 0.3),
                            end: const Offset(1, 1),
                          )
                          .then()
                          .shake(
                            duration: 1500.ms,
                          ),

                      const SizedBox(height: 20),

                      const Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        '\nCelebrations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 43,
                          height: 1.1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(
                            duration: 1000.ms,
                          )
                          .slideY(
                            begin: 0.4,
                            end: 0,
                          ),

                      const SizedBox(height: 45),

                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BirthdayPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.celebration,
                            size: 30,
                          ),
                          label: const Text(
                          'Click here for Surprise !',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// BIRTHDAY CELEBRATION PAGE
// =====================================================

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage>
    with TickerProviderStateMixin {
  // Confetti controller
  late ConfettiController _confettiController;

  // Balloon animation controller
  late AnimationController _balloonController;

  // Birthday music player
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _musicPlaying = true;

  @override
  void initState() {
    super.initState();

    // Confetti animation duration
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 8),
    );

    // Balloon animation
    _balloonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _balloonController.repeat(
      reverse: true,
    );

    // Start confetti and birthday music
    _startCelebration();
  }

  // ===================================================
  // MUSIC CODE IS HERE
  // ===================================================

  Future<void> _startCelebration() async {
    // Start falling confetti
    _confettiController.play();

    // Repeat music continuously
    await _audioPlayer.setReleaseMode(
      ReleaseMode.loop,
    );

    // Play happy birthday MP3
    await _audioPlayer.play(
      AssetSource(
        'audio/happy_birthday.mp3',
      ),
    );
  }

  // Music ON/OFF button
  Future<void> _toggleMusic() async {
    if (_musicPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }

    setState(() {
      _musicPlaying = !_musicPlaying;
    });
  }

  // Play celebration again
  Future<void> _celebrateAgain() async {
    _confettiController.play();

    await _audioPlayer.seek(
      Duration.zero,
    );

    if (!_musicPlaying) {
      await _audioPlayer.resume();

      setState(() {
        _musicPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();

    _balloonController.dispose();

    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // =============================================
          // COLORFUL BACKGROUND
          // =============================================

          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE1EC),
                  Color(0xFFE8D7FF),
                  Color(0xFFFFF3B0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // =============================================
          // ANIMATED BALLOONS
          // =============================================

          AnimatedBuilder(
            animation: _balloonController,
            builder: (context, child) {
              final value = _balloonController.value;

              return Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 100 + (value * 35),
                    child: Transform.rotate(
                      angle: sin(value * pi * 2) * 0.12,
                      child: const Text(
                        '🎈',
                        style: TextStyle(
                          fontSize: 75,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 5,
                    top: 180 - (value * 40),
                    child: Transform.rotate(
                      angle: cos(value * pi * 2) * 0.12,
                      child: const Text(
                        '🎈',
                        style: TextStyle(
                          fontSize: 80,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 15,
                    bottom: 80 - (value * 30),
                    child: const Text(
                      '🎈',
                      style: TextStyle(
                        fontSize: 65,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 15,
                    bottom: 150 + (value * 25),
                    child: const Text(
                      '🎈',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // =============================================
          // MAIN PAGE CONTENT
          // =============================================

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    // Back and music buttons
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),

                        IconButton(
                          onPressed: _toggleMusic,
                          icon: Icon(
                            _musicPlaying
                                ? Icons.volume_up
                                : Icons.volume_off,
                            size: 30,
                          ),
                        ),
                      ],
                    ),

                    // Birthday title
                    const Text(
                      '🎉 HAPPY BIRTHDAY 🎉',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7B1FA2),
                      ),
                    )
                        .animate()
                        .fadeIn(
                          duration: 700.ms,
                        )
                        .slideY(
                          begin: -0.5,
                          end: 0,
                        ),

                    const SizedBox(height: 15),

                    // Birthday message
                    const Text(
                      'May your day be filled with\njoy, and happiness!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ===================================
                    // BIRTHDAY CAKE IMAGE
                    // ===================================

                    Container(
                      width: 300,
                      height: 300,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withValues(alpha: 0.30),
                            blurRadius: 25,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          // IMAGE FILE LOCATION
                          'assets/images/birthday_cake.png',

                          fit: BoxFit.cover,

                          // If image is missing, show cake emoji
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                '🎂',
                                style: TextStyle(
                                  fontSize: 180,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(
                            reverse: true,
                          ),
                        )
                        .scale(
                          duration: 1800.ms,
                          begin: const Offset(0.96, 0.96),
                          end: const Offset(1.04, 1.04),
                        ),

                    const SizedBox(height: 25),

                    // Flowers
                    const Text(
                      '🌸 🌹 🌺 🌻 🌼',
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Celebrate again button
                    ElevatedButton.icon(
                      onPressed: _celebrateAgain,
                      icon: const Icon(
                        Icons.celebration,
                      ),
                      label: const Text(
                        'CELEBRATE AGAIN',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF7B1FA2),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // =============================================
          // FALLING CONFETTI
          // =============================================

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 40,
              gravity: 0.25,
              emissionFrequency: 0.04,
              maxBlastForce: 30,
              minBlastForce: 10,
              colors: const [
                Colors.pink,
                Colors.purple,
                Colors.orange,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

