import 'dart:async';
// import 'dart:developer';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/controller/getxController.dart';
// import 'package:voice_assistant/controller/sharePrefrence.dart';
import 'package:voice_assistant/screens/mainScreen.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/screens/sharePreference/onboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final getxObj = Get.find<getController>();
late SharedPreferences sp;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    call();
    super.initState();
  }

  Future<void> call() async {
    sp = await SharedPreferences.getInstance();
    final isOnboarding = sp.getBool('isOnboarding') ?? false;
    final isLogin = sp.getString("isEmail") ?? "not";
    bool darkMode = sp.getBool("darkMode") ?? true;
    getxObj.darkMode.value = darkMode;
    if (isOnboarding) {
      if (isLogin != "not") {
        Future.delayed(Duration(seconds: 3), () {
          Get.offAll(
            () => MainScreen(data: {"email": isLogin}),
            transition: Transition.zoom,
          );
        });
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Get.offAll(() => LoginScreen(), transition: Transition.zoom);
        });
      }
    } else {
      Get.offAll(() => WelcomeScreen(), transition: Transition.zoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              top: -30,
              left: -100,
              child: _blurGlow(
                size: size,
                color: const Color(0xFF2962FF),
                opacity: 0.20,
              ),
            ),
            Positioned(
              bottom: -120,
              right: -120,
              child: _blurGlow(
                size: size,
                color: const Color(0xFF2979FF),
                opacity: 0.20,
              ),
            ),
            Container(
              height: size.height * 0.85,
              margin: const EdgeInsets.only(left: 32),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
              decoration: BoxDecoration(
                color: colorsScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.18),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: getxObj.darkMode.value
                        ? Colors.black.withOpacity(0.6)
                        : Colors.transparent,
                    blurRadius: 30,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        "GEN-Z AI ASSISTANCE",
                        textAlign: TextAlign.left,

                        speed: const Duration(milliseconds: 110),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.070,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 22,
                              offset: const Offset(0, 10),
                            ),
                            Shadow(
                              color: const Color(0xFF4FC3F7).withOpacity(0.45),
                              blurRadius: 35,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5,
              bottom: 70,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  "Next generation cognitive intelligence interface.",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Positioned(
              right: 40,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  "HELLO. I AM YOUR PERSONAL AI DESIGNED TO CHAT, LISTEN, SEE & TRANSLATE SMART. FAST. ALWAYS READY.",
                  textAlign: TextAlign.right,

                  style: TextStyle(fontSize: 15, height: 2),
                ),
              ),
            ),
            Positioned(
              bottom: 140,
              right: 40,
              child: Container(
                width: 100,
                height: 2,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 38, 0, 255),
                ),
              ),
            ),
            Positioned(
              right: 40,
              top: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(67, 96, 125, 139),
                  elevation: 0,
                  side: BorderSide(color: Colors.blueGrey),
                ),
                child: TextGradiate(
                  text: Text(
                    "AI",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
                  gradientType: GradientType.linear,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.blueGrey.withOpacity(0.4),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "© 2025 · Developed by Pritam",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.withOpacity(0.85),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.blueGrey.withOpacity(0.4),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blurGlow({
    required Size size,
    required Color color,
    required double opacity,
  }) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 220, sigmaY: 220),
      child: Container(
        height: size.width * 0.9,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(opacity),
        ),
      ),
    );
  }
}
