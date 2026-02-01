import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:voice_assistant/controller/getxController.dart';

class Texttospeetch {
  final speachEnd = Get.find<getController>();
  final FlutterTts _tts = FlutterTts();
  String currentLanguage = "en-US";

  /// Initialize TTS based on selected language & voice
  Future<void> iniTts() async {
    String language = speachEnd.selectOutputLanguage.value == 0
        ? "en-US"
        : speachEnd.selectOutputLanguage.value == 1
        ? "bn-IN"
        : speachEnd.selectOutputLanguage.value == 2
        ? "hi-IN"
        : "ja-JP";

    // Only set language if changed
    if (currentLanguage != language) {
      currentLanguage = language;
      await _tts.setLanguage(language);
    }

    // Set voice parameters based on selectVoice
    switch (speachEnd.selectVoice.value) {
      case 0: // Normal
        await _tts.setSpeechRate(0.5);
        await _tts.setPitch(1.0);
        break;
      case 1: // Deep & slow
        await _tts.setSpeechRate(0.4);
        await _tts.setPitch(0.85);
        break;
      case 2: // Sharp & fast
        await _tts.setSpeechRate(0.6);
        await _tts.setPitch(1.2);
        break;
      default:
        await _tts.setSpeechRate(0.5);
        await _tts.setPitch(1.0);
    }

    await _tts.setVolume(1.0);

    _tts.setCompletionHandler(() {
      speachEnd.statusData.value = "TAP TO START";
      speachEnd.speakingEnd.value = false;
    });

    _tts.setStartHandler(() {
      speachEnd.speakingEnd.value = true;
    });
  }

  /// Speak text safely
  Future<void> speakText(String text) async {
    await iniTts(); // ensures language & voice updated
    await _tts.stop(); // stop any ongoing speech
    await Future.delayed(
      const Duration(milliseconds: 100),
    ); // small safety delay
    await _tts.speak(text);
  }

  /// Stop speech
  Future<void> stopSpeak() async {
    speachEnd.speakingEnd.value = false;
    await _tts.stop();
  }
}
