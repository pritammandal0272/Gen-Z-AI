import 'dart:math';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/functions/settingsFunctions.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/historyScreen/view/historyScreen.dart';
import 'package:voice_assistant/screens/homeScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';
import 'package:voice_assistant/widgets/textToSpeetch.dart';

class SmartAssistance extends StatefulWidget {
  final Map data;
  const SmartAssistance({super.key, required this.data});

  @override
  State<SmartAssistance> createState() => _SmartAssistanceState();
}

final getxObj = Get.find<getController>();

class _SmartAssistanceState extends State<SmartAssistance> {
  final List<Color> backgroundColorsAssistance = [
    Colors.white,
    const Color(0xFF3B82F6),
    const Color(0xFF2563EB),
    const Color(0xFF22D3EE),
    const Color(0xFF14B8A6),
    const Color(0xFF8B5CF6),
    const Color(0xFF9333EA),
    const Color(0xFFF43F5E),
    const Color(0xFFEC4899),
    const Color(0xFFF59E0B),
    const Color(0xFF84CC16),
  ];
  var tts = Texttospeetch();
  @override
  void initState() {
    super.initState();
    tts.iniTts();
  }

  @override
  void dispose() {
    Initialize_Assistence_SettingsGetxVariable(getxObj.logInUserData);
    tts.stopSpeak();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;

    void testVoice() async {
      String replyLanguage;
      switch (getxObj.selectOutputLanguage.value) {
        case 0:
          replyLanguage =
              "Hello ${getxObj.logInUserData.isNotEmpty ? getxObj.logInUserData[0]["UserName"] : "Dear"} I am your voice assistant. You are speaking now. I will reply in English.";
          break;

        case 1:
          replyLanguage =
              "হ্যালো ${getxObj.logInUserData.isNotEmpty ? getxObj.logInUserData[0]["UserName"] : "Dear"} আমি তোমার ভয়েস অ্যাসিস্ট্যান্ট। তুমি এখন কথা বলছো। আমি বাংলায় উত্তর দেব।";
          break;

        case 2:
          replyLanguage =
              "हैलो ${getxObj.logInUserData.isNotEmpty ? getxObj.logInUserData[0]["UserName"] : "Dear"} मैं आपका वॉइस असिस्टेंट हूँ। आप अभी बोल रहे हैं। मैं हिंदी में उत्तर दूँगा।";
          break;

        case 3:
          replyLanguage =
              "こんにちは ${getxObj.logInUserData.isNotEmpty ? getxObj.logInUserData[0]["UserName"] : "Dear"}";
          break;

        default:
          replyLanguage =
              "Hello ${getxObj.logInUserData.isNotEmpty ? getxObj.logInUserData[0]["UserName"] : "Dear"}. I am your voice assistant. I will reply in English.";
      }
      await tts.iniTts();
      await tts.speakText(replyLanguage.toString());
      print("object");
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Column(
          spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chosse your",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                widget.data["backbuttonPress"]
                    ? InkWell(onTap: Get.back, child: Icon(Icons.arrow_forward))
                    : SizedBox(),
              ],
            ),
            TextGradiate(
              text: Text(
                "Assistance",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
              gradientType: GradientType.linear,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            SizedBox(height: 2),
            Text(
              "Chosse Ai Sound and intracts with you. ",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                if (getxObj.logInUserData[0]["Email_or_Phone"] == "") {
                  ShowPopover(context);
                } else {
                  Get.to(
                    () => HistoryScreen(historyType: "Voice History"),
                    transition: Transition.rightToLeft,
                  );
                }
              },
              child: Icon(Icons.history),
            ),
          ),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            height: 0.5,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: widget.data["backbuttonPress"] ? 10 : 100,
                ),
                // decoration: BoxDecoration(color: Color.fromRGBO(16, 19, 34, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(height: 5),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Voice",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Icon(
                                  Icons.volume_up,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    testVoice();
                                  },
                                  child: Text(
                                    "Test Audio",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: AlignmentGeometry.center,
                                children: [
                                  getxObj.selectVoice.value == 0
                                      ? ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xFF5B8CFF,
                                              ).withOpacity(0.20),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  InkWell(
                                    onTap: () {
                                      getxObj.selectVoice.value = 0;
                                    },
                                    child: Container(
                                      height: getxObj.selectVoice.value == 0
                                          ? 110
                                          : 103,
                                      width: getxObj.selectVoice.value == 0
                                          ? 110
                                          : 103,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: getxObj.selectVoice.value == 0
                                            ? Border.all(
                                                color: Colors.blue,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: const Color.fromARGB(
                                                  39,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                                width: 0.5,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        // image: DecorationImage(
                                        //   image: AssetImage("assets/assistanceMale.png"),
                                        // ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/assistanceMale.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  getxObj.selectVoice.value == 0
                                      ? Positioned(
                                          bottom: 0,
                                          right: 8,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),

                              Stack(
                                alignment: AlignmentGeometry.center,
                                children: [
                                  getxObj.selectVoice.value == 1
                                      ? ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xFF5B8CFF,
                                              ).withOpacity(0.20),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  InkWell(
                                    onTap: () {
                                      getxObj.selectVoice.value = 1;
                                    },
                                    child: Container(
                                      height: getxObj.selectVoice.value == 1
                                          ? 110
                                          : 103,
                                      width: getxObj.selectVoice.value == 1
                                          ? 110
                                          : 103,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: getxObj.selectVoice.value == 1
                                            ? Border.all(
                                                color: Colors.blue,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: const Color.fromARGB(
                                                  39,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                                width: 0.5,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        // image: DecorationImage(
                                        //   image: AssetImage("assets/assistanceMale.png"),
                                        // ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/assistanceFemale.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  getxObj.selectVoice.value == 1
                                      ? Positioned(
                                          bottom: 0,
                                          right: 8,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              Stack(
                                alignment: AlignmentGeometry.center,
                                children: [
                                  getxObj.selectVoice.value == 2
                                      ? ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xFF5B8CFF,
                                              ).withOpacity(0.20),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  InkWell(
                                    onTap: () {
                                      getxObj.selectVoice.value = 2;
                                      // log("$getxObj.selectVoice.value");
                                    },
                                    child: Container(
                                      height: getxObj.selectVoice.value == 2
                                          ? 110
                                          : 103,
                                      width: getxObj.selectVoice.value == 2
                                          ? 110
                                          : 103,
                                      padding: getxObj.selectVoice.value == 2
                                          ? EdgeInsets.all(2)
                                          : null,
                                      decoration: BoxDecoration(
                                        border: getxObj.selectVoice.value == 2
                                            ? Border.all(
                                                color: Colors.blue,
                                                width: 3,
                                              )
                                            : Border.all(
                                                color: const Color.fromARGB(
                                                  39,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                                width: 0.5,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        // image: DecorationImage(
                                        //   image: AssetImage("assets/assistanceMale.png"),
                                        // ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/assistanceFemale2.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  getxObj.selectVoice.value == 2
                                      ? Positioned(
                                          bottom: 0,
                                          right: 8,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: getxObj.darkMode.value
                          ? const Color.fromARGB(111, 158, 158, 158)
                          : Color.fromRGBO(37, 100, 235, 0.474),
                      height: 0.5,
                    ),
                    Text(
                      "Output Language",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Column(
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  getxObj.selectOutputLanguage.value = 0;
                                },
                                child: languageContainer(
                                  "assets/englishLanguage.png",
                                  "English (US)",
                                  "Default",
                                  getxObj.selectOutputLanguage.value == 0
                                      ? Colors.blue
                                      : Colors.grey,
                                  getxObj.selectOutputLanguage.value == 0
                                      ? 2.0
                                      : 0.5,
                                  context,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  getxObj.selectOutputLanguage.value = 1;
                                },
                                child: languageContainer(
                                  "assets/bengaliLanguage.png",
                                  "Bengali",
                                  "Select",
                                  getxObj.selectOutputLanguage.value == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                  getxObj.selectOutputLanguage.value == 1
                                      ? 2.0
                                      : 0.5,
                                  context,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  getxObj.selectOutputLanguage.value = 2;
                                },
                                child: languageContainer(
                                  "assets/hindiLanguage.png",
                                  "Hindi",
                                  "Select",
                                  getxObj.selectOutputLanguage.value == 2
                                      ? Colors.blue
                                      : Colors.grey,
                                  getxObj.selectOutputLanguage.value == 2
                                      ? 2.0
                                      : 0.5,
                                  context,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  getxObj.selectOutputLanguage.value = 3;
                                },
                                child: languageContainer(
                                  "assets/japanLanguage.png",
                                  "Japanese",
                                  "Select",
                                  getxObj.selectOutputLanguage.value == 3
                                      ? Colors.blue
                                      : Colors.grey,
                                  getxObj.selectOutputLanguage.value == 3
                                      ? 2.0
                                      : 0.5,
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "Audio Settings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorsScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x24020617),
                              blurRadius: 20,
                              offset: Offset(0, 0),
                            ),
                            BoxShadow(
                              color: Color(0x14020617),
                              blurRadius: 3,
                              offset: Offset(0, 0),
                            ),
                          ],
                          border: Border.all(
                            color: getxObj.darkMode.value
                                ? const Color.fromARGB(42, 158, 158, 158)
                                : Color.fromRGBO(37, 100, 235, 0.474),
                          ),
                        ),
                        child: Column(
                          spacing: 15,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 5,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: getxObj.darkMode.value
                                            ? Colors.grey.withOpacity(0.1)
                                            : Color.fromRGBO(
                                                37,
                                                100,
                                                235,
                                                0.605,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        border: Border.all(
                                          color: getxObj.darkMode.value
                                              ? const Color.fromARGB(
                                                  60,
                                                  158,
                                                  158,
                                                  158,
                                                )
                                              : Color.fromRGBO(37, 100, 235, 1),
                                        ),
                                      ),
                                      child: Icon(Icons.volume_up_outlined),
                                    ),
                                    Text(
                                      "Assistance Volume",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${getxObj.volumnRangeSlider.value.toInt()}%",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Slider(
                              padding: EdgeInsets.all(0),

                              value: getxObj.volumnRangeSlider.value,
                              min: 0,
                              max: 100,
                              activeColor: Colors.blue,
                              thumbColor: Colors.white,
                              onChanged: (value) {
                                getxObj.volumnRangeSlider.value = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Assistance Theme",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 200),
                          child: _themeChangeAssistance(),
                        ),
                        _previewAssistance(context),
                      ],
                    ),

                    Text(
                      "Select Mode",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              getxObj.selectMode.value = 0;
                            },
                            child: SelectModeContainer(
                              context,
                              "Normal Mode",
                              "Relaxed conversation, creative writing ideas, and daily planning help.",
                              "assets/normalMode.png",
                              "Casual Chat",
                              "Planing",
                              getxObj.selectMode.value == 0
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              getxObj.selectMode.value = 1;
                            },
                            child: SelectModeContainer(
                              context,
                              "Casual Chat",
                              "Optimized for academic research, summarization, and citing sources accurately.",
                              "assets/studyMode.png",
                              "Research",
                              "Citations",
                              getxObj.selectMode.value == 1
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              getxObj.selectMode.value = 2;
                            },
                            child: SelectModeContainer(
                              context,
                              "Devloper Mode",
                              "Advanced code generation, debugging, and technical documentation assistance.",
                              "assets/devMode.png",
                              "Creative",
                              "Planing",
                              getxObj.selectMode.value == 2
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          widget.data["backbuttonPress"]
                              ? SizedBox()
                              : saveSettings(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.data["backbuttonPress"] ? saveSettings() : SizedBox(),
        ],
      ),
    );
  }

  Widget saveSettings() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () async {
          final bool result = await saveSettingsAssistance(
            getxObj.selectVoice.value,
            getxObj.selectOutputLanguage.value == 0
                ? "english"
                : getxObj.selectOutputLanguage.value == 1
                ? "bengali"
                : getxObj.selectOutputLanguage.value == 2
                ? "hindi"
                : "japanese",
            getxObj.assistanceFontSizeGetx.value.toInt(),
            getxObj.assistanceFontBoldGetx.value ? 1 : 0,
            getxObj.backgroundColorsAssistanceGetx.value,
            getxObj.textColorsAssistanceGetx.value,

            getxObj.selectMode.value == 0
                ? "normal"
                : getxObj.selectMode.value == 1
                ? "casual"
                : "devloper",
          );
          if (!result) {
            showSnackbarFunction(
              context,
              "No changes were made.",
              Colors.deepOrange,
              Icons.info,
            );
          } else {
            showSnackbarFunction(
              context,
              "Changes saved successfully.",
              Colors.blue,
              Icons.check_circle,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Color.fromRGBO(13, 89, 242, 1),
          backgroundColor: Color.fromRGBO(13, 89, 242, 1),
        ),
        child: Text(
          "Save Preferences",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Widget languageContainer(
  imagePath,
  languageType,
  select,
  Color activeColor,
  double borderSize,
  context,
) {
  final colorsScheme = Theme.of(context).colorScheme;
  return Container(
    width: MediaQuery.of(context).size.width * 0.45,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: colorsScheme.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: activeColor == Colors.blue
            ? activeColor
            : const Color.fromARGB(57, 158, 158, 158),
        width: borderSize,
      ),
      boxShadow: activeColor == Colors.blue
          ? [
              BoxShadow(
                color: activeColor.withOpacity(0.5),
                offset: Offset(0, 0),
                blurRadius: 5,
              ),
            ]
          : [
              BoxShadow(
                color: Color(0x24020617),
                blurRadius: 28,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color(0x14020617),
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
    ),
    child: Row(
      spacing: 6,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: activeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(300),
            border: Border.all(color: const Color.fromARGB(60, 158, 158, 158)),
          ),
          child: Image.asset(imagePath, height: 25, width: 25),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languageType,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              select,
              style: TextStyle(
                color: activeColor == Colors.blue
                    ? activeColor
                    : const Color.fromARGB(101, 158, 158, 158),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget SelectModeContainer(
  context,
  title,
  subText,
  bgImage,
  tag1,
  tag2,
  modeColor,
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: 270,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: modeColor == Colors.blue
                  ? modeColor.withOpacity(0.20)
                  : Colors.transparent,
              blurRadius: 3,
              // spreadRadius: 0.01,
            ),
          ],
        ),
      ),
      Container(
        height: 260,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: modeColor == Colors.blue
                ? modeColor
                : modeColor.withOpacity(0.5),
            width: modeColor == Colors.blue ? 2.5 : 0.5,
          ),
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.70),
                Colors.black.withOpacity(0.99),
              ],
            ),
          ),
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      minimumSize: Size.zero,
                      backgroundColor: modeColor.withOpacity(0.20),
                      iconColor: modeColor,
                      iconSize: 26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(300),
                        side: BorderSide(color: modeColor),
                      ),
                    ),
                    onPressed: () {},
                    label: Icon(Icons.chat_outlined),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        modeColor != Colors.blue
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(
                                    93,
                                    158,
                                    158,
                                    158,
                                  ),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  "SELECT",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: const Color.fromARGB(
                                      162,
                                      255,
                                      255,
                                      255,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                subText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.5,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: modeColor.withOpacity(0.20),
                      border: Border.all(color: modeColor),
                    ),
                    child: Text(
                      tag1,
                      style: TextStyle(
                        fontSize: 14,
                        color: modeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: modeColor.withOpacity(0.20),
                      border: Border.all(color: modeColor),
                    ),
                    child: Text(
                      tag2,
                      style: TextStyle(
                        fontSize: 14,
                        color: modeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _themeChangeAssistance() {
  return Obx(
    () => Container(
      // margin: EdgeInsets.only(bottom: 12, left: 10, right: 10),
      padding: EdgeInsets.only(
        top: 10 + (getxObj.assistanceFontSizeGetx.value * 3),
      ),
      decoration: BoxDecoration(
        color: getxObj.darkMode.value
            ? Color.fromARGB(141, 44, 61, 100)
            : const Color.fromARGB(143, 9, 117, 3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(42, 158, 158, 158)),
      ),
      child: Column(
        spacing: 10,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Font Size (1 - 30)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getxObj.assistanceFontSizeGetx.value.toInt().toString(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.format_size, color: Colors.blueGrey, size: 20),
                    Expanded(
                      child: Slider(
                        padding: EdgeInsets.all(0),
                        value: getxObj.assistanceFontSizeGetx.value,
                        min: 7,
                        max: 30,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          getxObj.assistanceFontSizeGetx.value = value;
                        },
                      ),
                    ),
                    Icon(Icons.format_size, color: Colors.white, size: 25),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: const Color.fromARGB(128, 96, 125, 139)),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bold Text",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: getxObj.assistanceFontBoldGetx.value,
                      padding: EdgeInsets.all(0),
                      thumbColor: WidgetStatePropertyAll(Colors.white),
                      activeColor: const Color.fromARGB(255, 0, 94, 255),
                      thumbIcon: WidgetStatePropertyAll(
                        Icon(
                          getxObj.assistanceFontBoldGetx.value
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: getxObj.assistanceFontBoldGetx.value
                              ? Colors.blueAccent
                              : Colors.red,
                        ),
                      ),
                      onChanged: (value) {
                        getxObj.assistanceFontBoldGetx.value = value;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: const Color.fromARGB(128, 96, 125, 139)),

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Theme",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(66, 70, 78, 0.299),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            backgroundColor: getxObj.assistanceThemeGetx.value
                                ? const Color.fromARGB(101, 33, 149, 243)
                                : Colors.transparent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            elevation: getxObj.assistanceThemeGetx.value
                                ? 2
                                : 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            getxObj.assistanceThemeGetx.value = true;
                            // log("message");
                          },
                          child: Text(
                            "Background Color",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            backgroundColor: !getxObj.assistanceThemeGetx.value
                                ? const Color.fromARGB(101, 33, 149, 243)
                                : Colors.transparent,

                            elevation: !getxObj.assistanceThemeGetx.value
                                ? 2
                                : 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            getxObj.assistanceThemeGetx.value = false;
                          },
                          child: Text(
                            "Text Color",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "Choose Color",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: DummyData.backgroundColorsAi.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          getxObj.assistanceThemeGetx.value
                              ? getxObj.backgroundColorsAssistanceGetx.value =
                                    index
                              : getxObj.textColorsAssistanceGetx.value = index;
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  getxObj.assistanceThemeGetx.value &&
                                      getxObj
                                              .backgroundColorsAssistanceGetx
                                              .value ==
                                          index
                                  ? Colors.blue
                                  : !getxObj.assistanceThemeGetx.value &&
                                        getxObj
                                                .textColorsAssistanceGetx
                                                .value ==
                                            index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: getxObj.assistanceThemeGetx.value
                                ? DummyData.backgroundColorsAi[index]
                                : DummyData.textColorsAi[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      backgroundColor: const Color.fromARGB(116, 33, 243, 159),

                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 7,
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      getxObj.backgroundColorsAssistanceGetx.value = 3;
                      getxObj.textColorsAssistanceGetx.value = 0;
                      getxObj.assistanceFontSizeGetx.value = 15;
                      getxObj.assistanceFontBoldGetx.value = false;
                      getxObj.assistanceThemeGetx.value = true;
                    },
                    child: Text(
                      "Click Set Default Settings",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

Widget _previewAssistance(context) {
  final colorsScheme = Theme.of(context).colorScheme;

  return Container(
    padding: EdgeInsets.only(bottom: 80, left: 20, right: 20, top: 10),

    decoration: BoxDecoration(
      color: colorsScheme.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: getxObj.darkMode.value
            ? const Color.fromARGB(42, 158, 158, 158)
            : const Color.fromARGB(46, 0, 0, 0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          "PREVIEW",
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            height: 1,
            fontSize: 14,
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.7,
          // height: getxObj.assistanceHeightContainer.value,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: getxObj.darkMode.value
                ? Color.fromRGBO(25, 27, 47, 1)
                : const Color.fromARGB(51, 96, 125, 139),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color.fromRGBO(34, 211, 238, 1),
              width: 0.8,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxHeight: 400),
                  decoration: BoxDecoration(
                    color:
                        DummyData.backgroundColorsAi[getxObj
                            .backgroundColorsAssistanceGetx
                            .value],
                    borderRadius: BorderRadius.circular(15),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: DummyData
                    //         .backgroundColorsAi[getxObj
                    //             .backgroundColorsAssistanceGetx
                    //             .value]
                    //         .withOpacity(0.20),
                    //     blurRadius: 5,
                    //     // spreadRadius: 0.01,
                    //   ),
                    // ],
                    border: BoxBorder.all(
                      color: Color.fromRGBO(34, 211, 238, 1),
                      width: 0.8,
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      "This is an example of formatted text.",
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
                ),
              ),

              Obx(
                () => Transform.translate(
                  offset: Offset(0, 33),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomAnimationBuilder(
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
                                offset: Offset(
                                  cos(angle) * 55,
                                  sin(angle) * 55,
                                ),
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
                      ),

                      InkWell(
                        child: AvatarGlow(
                          glowColor:
                              DummyData.backgroundColorsAi[getxObj
                                  .backgroundColorsAssistanceGetx
                                  .value],
                          glowRadiusFactor: 0.5,
                          duration: Duration(seconds: 2),
                          repeat: true,

                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DummyData
                                  .backgroundColorsAi[getxObj
                                      .backgroundColorsAssistanceGetx
                                      .value]
                                  .withOpacity(0.6),

                              border: Border.all(
                                color:
                                    DummyData.backgroundColorsAi[getxObj
                                        .backgroundColorsAssistanceGetx
                                        .value],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: DummyData
                                      .backgroundColorsAi[getxObj
                                          .backgroundColorsAssistanceGetx
                                          .value]
                                      .withOpacity(0.6),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 32,
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
      ],
    ),
  );
}
