import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_gradiate/text_gradiate.dart';
// import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

late SharedPreferences sp;
// final getxObj = Get.find<getController>();

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.light, // iOS
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B2233), Color(0xFF071B2A), Color(0xFF05131E)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 30,
                children: [
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E40FF).withOpacity(0.2),
                      border: Border.all(color: Color(0xFF1E40FF), width: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Welcome 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1,
                      ),
                    ),
                  ),

                  Column(
                    spacing: 10,
                    children: [
                      Text(
                        "Your Smart ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),

                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextGradiate(
                            text: Text(
                              "AI Assiatance",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            gradientType: GradientType.linear,
                            colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          "Chat, Translate, Scan & Talk — all in one place",
                          textAlign: TextAlign.center,

                          style: TextStyle(color: Colors.white60, fontSize: 17),
                        ),
                      ),
                    ],
                  ),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    physics: NeverScrollableScrollPhysics(),
                    children: const [
                      FeatureCard(
                        icon: Icons.chat_bubble_outline,
                        title: "AI Chatbot",
                        subtitle: "Smart text-based assistance",
                        image: "assets/toyImg.png",
                      ),
                      FeatureCard(
                        icon: Icons.mic_none,
                        title: "AI Voice",
                        subtitle: "Natural voice conversations",
                        image: "assets/voiceWave.png",
                      ),
                      FeatureCard(
                        icon: Icons.translate,
                        title: "Translator",
                        subtitle: "Instant multi-language translation",
                        image: "assets/translator.jpg",
                      ),
                      FeatureCard(
                        icon: Icons.qr_code_scanner,
                        title: "AI Scanner",
                        subtitle: "Extract text from images",
                        image: "assets/scanOnboarding.jpg",
                      ),
                    ],
                  ),
                  Column(
                    spacing: 15,
                    children: [
                      Center(
                        child: Text(
                          "Your AI is ready to help you",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1E40FF).withOpacity(0.3),
                            side: BorderSide(color: Color(0xFF1E40FF)),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            _routeNextPage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 6,
                            children: [
                              Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String image;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(27, 158, 158, 158),
                offset: Offset(0, 0),
                blurRadius: 3,
              ),
            ],
            border: Border.all(
              color: const Color.fromARGB(161, 158, 158, 158),
              width: 0.5,
            ),
          ),
          // child:
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(124, 0, 0, 0),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E40FF).withOpacity(0.3),
                    border: Border.all(color: Color(0xFF1E40FF), width: 0.5),
                    borderRadius: BorderRadius.circular(300),
                  ),
                  child: Icon(icon, color: Colors.white, size: 25),
                ),
                Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _routeNextPage() async {
  sp = await SharedPreferences.getInstance();
  sp.setBool('isOnboarding', true);
  Get.offAll(() => LoginScreen(), transition: Transition.zoom);
}
