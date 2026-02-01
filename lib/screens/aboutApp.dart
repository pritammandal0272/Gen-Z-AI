import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/controller/getxController.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

final getxObj = Get.find<getController>();

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextGradiate(
          text: Text(
            "About App",
            style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
          gradientType: GradientType.linear,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: getxObj.darkMode.value
                      ? const Color.fromARGB(111, 158, 158, 158)
                      : Color.fromRGBO(37, 100, 235, 0.474),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Smart Voice Assistant',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'A powerful chatbot app with Voice Assistance, Language Translation, and Smart Scan features to make your daily tasks faster and easier.',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            SizedBox(height: 20),

            Text(
              'Key Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),

            FeatureTile(
              icon: Icons.smart_toy,
              title: 'AI Chatbot',
              description:
                  'Chat with an intelligent AI chatbot to get answers, suggestions, and help in real-time.',
            ),
            FeatureTile(
              icon: Icons.mic,
              title: 'Voice Assistant',
              description:
                  'Talk to the app using your voice. Ask questions, give commands, and get instant responses hands-free.',
            ),
            FeatureTile(
              icon: Icons.translate,
              title: 'Language Translation',
              description:
                  'Translate text and voice into multiple languages quickly and accurately.',
            ),
            FeatureTile(
              icon: Icons.qr_code_scanner,
              title: 'Scan & Detect',
              description:
                  'Scan text, codes, or documents and instantly understand or translate the content.',
            ),

            SizedBox(height: 20),
            Text(
              'Why Choose This App?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '• Simple and user-friendly interface\n'
              '• Fast and accurate voice recognition\n'
              '• Supports multiple languages\n'
              '• Perfect for students, travelers, and professionals',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),

            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 10),

            Center(
              child: Text(
                'Version 1.0.0\n© 2026 Smart Voice Assistant',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
