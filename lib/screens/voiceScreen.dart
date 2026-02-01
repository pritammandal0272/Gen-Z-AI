import 'dart:math';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/auth/giminiApi.dart';
import 'package:voice_assistant/controller/dataBase/insertValueDB.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/widgets/speakingBox.dart';
import 'package:voice_assistant/widgets/textToSpeetch.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final SpeechToText _speech = SpeechToText();
  var getxController = Get.find<getController>();
  var tts = Texttospeetch();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    tts.iniTts();
  }

  @override
  void dispose() {
    getxController.voiceText.value = "Listening...";
    getxController.gminiAns.value = "";
    tts.stopSpeak();
    _speech.stop();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          print(status);
          _stopListening();
        }
      },
    );

    if (!available) {
      getxController.voiceText.value = "Speech recognition not available";
      return;
    }
    _startListening();
  }

  void _startListening() async {
    getxController.statusData.value = "LISTENING";
    getxController.voiceText.value = "Listening...";
    getxController.gminiAns.value = "";
    await _speech.listen(
      localeId: getxController.selectOutputLanguage.value == 0
          ? "en-US"
          : getxController.selectOutputLanguage.value == 1
          ? "bn-IN"
          : getxController.selectOutputLanguage.value == 2
          ? "hi-IN"
          : "ja-JP",
      onResult: (result) {
        getxController.voiceText.value = result.recognizedWords;
      },
    );

    getxController.isListening.value = true;
  }

  void _stopListening() async {
    await _speech.stop();
    getxController.statusData.value = "THINKING";
    if (getxController.voiceText.value != "Listening...") {
      String replyLanguage;
      switch (getxController.selectOutputLanguage.value) {
        case 0:
          replyLanguage = "Reply in English:";
          break;
        case 1:
          replyLanguage = "বাংলায় উত্তর দাও:";
          break;
        case 2:
          replyLanguage = "हिंदी में उत्तर दो:";
          break;
        case 3:
          replyLanguage = "英語で返信してください。:";
          break;
        default:
          replyLanguage = "Reply in English:";
      }

      String joinLanguage = "${getxController.voiceText.value} $replyLanguage";

      var reply = await giminiData(joinLanguage, "text", "");
      // ignore: unnecessary_null_comparison
      reply = (reply == null || reply.isEmpty)
          ? "Please try again later"
          : reply;
      final DateTime aiTime = DateTime.now();
      if (reply.isNotEmpty && reply != "Please try again later") {
        await insertVoiceHistory(
          getxController.logInUserData[0]["UserId"],
          getxController.voiceText.value,
          reply,
          DateFormat('MM/dd/yyyy h:mm a').format(aiTime),
        );
      }

      getxController.gminiAns.value = reply.toString();
      tts.speakText(reply.toString());
      getxController.isListening.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final getxObj = Get.find<getController>();
    final colorsScheme = Theme.of(context).colorScheme;
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorsScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromRGBO(34, 211, 238, 1), width: 0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() {
            return Align(
              alignment: Alignment.topLeft,
              child: Text(
                getxController.voiceText.value == "Listening..."
                    ? getxController.voiceText.value
                    : "Q. ${getxController.voiceText.value}",
                style: TextStyle(
                  color: getxController.voiceText.value == "Listening..."
                      ? Color.fromRGBO(11, 200, 74, 1)
                      : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          SizedBox(height: 10),
          Obx(() {
            return getxController.gminiAns.value == ""
                ? SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(maxHeight: 400),
                    decoration: BoxDecoration(
                      color: DummyData
                          .backgroundColorsAi[getxObj
                              .backgroundColorsAssistanceGetx
                              .value]
                          .withOpacity(0.60),
                      borderRadius: BorderRadius.circular(10),

                      border: BoxBorder.all(
                        color:
                            DummyData.backgroundColorsAi[getxObj
                                .backgroundColorsAssistanceGetx
                                .value],
                        width: 0.8,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        getxController.gminiAns.value,
                        style: TextStyle(
                          color:
                              DummyData.textColorsAi[getxObj
                                  .textColorsAssistanceGetx
                                  .value],
                          fontSize: getxObj.assistanceFontSizeGetx.value,
                          fontWeight: getxObj.assistanceFontBoldGetx.value
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                  );
          }),
          Obx(
            () => Transform.translate(
              offset: Offset(0, 33),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  getxController.isListening.value
                      ? OrbitBubbles()
                      : SizedBox(),
                  !getxController.speakingEnd.value
                      ? InkWell(
                          onTap: () {
                            if (getxController.isListening.value) {
                              getxController.isListening.value = false;

                              _stopListening();
                            } else {
                              getxController.isListening.value = true;
                              _startListening();
                            }
                          },

                          child: AvatarGlow(
                            glowColor:
                                DummyData.backgroundColorsAi[getxObj
                                    .backgroundColorsAssistanceGetx
                                    .value],
                            duration: Duration(seconds: 2),
                            repeat: getxController.isListening.value
                                ? true
                                : false,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getxController.isListening.value
                                    ? DummyData
                                          .backgroundColorsAi[getxObj
                                              .backgroundColorsAssistanceGetx
                                              .value]
                                          .withOpacity(0.6)
                                    : const Color.fromARGB(255, 43, 43, 43),
                                border: Border.all(
                                  color:
                                      DummyData.backgroundColorsAi[getxObj
                                          .backgroundColorsAssistanceGetx
                                          .value],
                                ),
                                boxShadow: [
                                  getxController.isListening.value
                                      ? BoxShadow(
                                          color: DummyData
                                              .backgroundColorsAi[getxObj
                                                  .backgroundColorsAssistanceGetx
                                                  .value]
                                              .withOpacity(0.6),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                        )
                                      : BoxShadow(),
                                ],
                              ),
                              child: Icon(
                                getxController.isListening.value
                                    ? Icons.mic
                                    : Icons.mic_off,
                                color: getxController.isListening.value
                                    ? Colors.white
                                    : const Color(0xFFB0BEC5),
                                size: 32,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 150,
                          child: Transform.translate(
                            offset: Offset(0, -50),
                            child: SpeakingBox(
                              hightBox: 200,
                              isBottomtextShow: false,
                              isHomeScreen: false,
                            ),
                          ),
                        ),

                  !getxController.speakingEnd.value
                      ? Transform.translate(
                          offset: Offset(
                            0,
                            getxController.statusData.value == "TAP TO START"
                                ? 50
                                : 90,
                          ),
                          child: Text(
                            getxController.statusData.value,
                            style: TextStyle(
                              color:
                                  getxController.statusData.value ==
                                      "TAP TO START"
                                  ? const Color(0xFFB0BEC5)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrbitBubbles extends StatelessWidget {
  const OrbitBubbles({super.key});
  @override
  Widget build(BuildContext context) {
    var getxObj = Get.find<getController>();
    return CustomAnimationBuilder(
      control: Control.loop,
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 6),
      curve: Curves.linear,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          children: List.generate(6, (index) {
            final angle = value + (index * pi / 3);

            return Transform.translate(
              offset: Offset(cos(angle) * 55, sin(angle) * 55),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DummyData
                      .backgroundColorsAi[getxObj
                          .backgroundColorsAssistanceGetx
                          .value]
                      .withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: DummyData
                          .backgroundColorsAi[getxObj
                              .backgroundColorsAssistanceGetx
                              .value]
                          .withOpacity(0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
