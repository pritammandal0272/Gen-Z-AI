import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/feedBackScreen.dart';

class SubmitedFeedback extends StatefulWidget {
  const SubmitedFeedback({super.key});

  @override
  State<SubmitedFeedback> createState() => _SubmitedFeedbackState();
}

class _SubmitedFeedbackState extends State<SubmitedFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late ConfettiController _confettiController;

  // Local state variables to hold preferences data
  int _rating = 0;
  String _feedbackText = "";

  final getxObj = Get.find<getController>();

  @override
  void initState() {
    super.initState();
    _loadData(); // Correct way to handle async data in initState

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
    });
  }

  // Proper async loading method
  Future<void> _loadData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _rating = sp.getInt("rating") ?? 0;
      _feedbackText = sp.getString("text") ?? "No feedback provided";
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isDark = getxObj.darkMode.value;

      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Success Circle & Confetti
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                      ],
                      numberOfParticles: 20,
                    ),
                    ScaleTransition(
                      scale: _scale,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: CustomPaint(painter: TickPainter(_controller)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Text(
                  "Feedback Received!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Thank you for helping us improve. Your input makes a real difference.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : const Color(0xFF6C757D),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // 2. Review Summary Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: isDark ? Border.all(color: Colors.white10) : null,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "YOUR REVIEW",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: isDark
                              ? Colors.blueAccent
                              : Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index <= _rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: Colors.amber,
                            size: 32,
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "\"$_feedbackText\"",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // 3. Action Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () async {
                      final sp = await SharedPreferences.getInstance();
                      await sp.setBool("feedBackSubmited", false);
                      Get.off(
                        () => const FeedBackScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? Colors.blueAccent
                          : Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Review Again",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TickPainter extends CustomPainter {
  final Animation<double> animation;
  TickPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.32, size.height * 0.5);
    path.lineTo(size.width * 0.45, size.height * 0.63);
    path.lineTo(size.width * 0.68, size.height * 0.38);

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      final extractPath = metric.extractPath(
        0,
        metric.length * animation.value,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(TickPainter oldDelegate) => true;
}
