// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:translator/translator.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/voiceScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';
import 'package:voice_assistant/widgets/textToSpeetch.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final SpeechToText _speech = SpeechToText();
  final getxObj = Get.find<getController>();
  final translator = GoogleTranslator();
  var getxController = Get.put(getController());
  final FocusNode _inputBoxKey = FocusNode();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final tts = Texttospeetch();
  bool flag = false;
  @override
  void initState() {
    getxObj.selectedLanguageSource.value = "English";
    getxObj.selectedLanguageDestination.value = "Bengali";
    getxObj.translateOutputText.value = "Translation....";
    getxObj.translateInputText.text = "";
    super.initState();
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          _stopListening();
        }
      },
    );

    if (!available) {
      return;
    }
    _startListening();
  }

  void _startListening() async {
    await _speech.listen(
      onResult: (result) {
        final value = result.recognizedWords;
        getxController.translateInputText.text = value;
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      },
    );
  }

  void _stopListening() async {
    await _speech.stop();
    _inputBoxKey.unfocus();
    getxObj.translateOutputText.value = await translateFunction(
      getxObj.selectedLanguageSource.value,
      getxObj.selectedLanguageDestination.value,
      getxObj.translateInputText.text,
    );
  }

  Future<String> translateFunction(s, d, value) async {
    if (value.trim().isEmpty) {
      showSnackbarFunction(
        context,
        "Please write Somthing !!",
        Colors.red,
        Icons.info,
      );
      return "Translation....";
    }
    var from = "";
    var to = "";
    for (var i in DummyData.languagesList) {
      if (i["name"] == s) {
        from = i["code"];
        break;
      }
    }
    for (var i in DummyData.languagesList) {
      if (i["name"] == d) {
        to = i["code"];
        break;
      }
    }
    final result = await translator.translate(
      value.toString(),
      from: from,
      to: to,
    );
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextGradiate(
          text: Text(
            "Translate",
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 15,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorsScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(68, 158, 158, 158),
                        width: 0.5,
                      ),
                    ),
                    // color: Colors.amber,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          // menuWidth: 100,
                          isDense: true,
                          menuMaxHeight: 300,
                          value: getxObj.selectedLanguageSource.value,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blueGrey,
                          ),
                          dropdownColor: colorsScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          items: DummyData.languagesList.map((value) {
                            return DropdownMenuItem(
                              value: value["name"].toString(),
                              child: Text(
                                value["name"].toString(),
                                selectionColor: Colors.white,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            getxObj.selectedLanguageSource.value = value
                                .toString();
                            getxObj.translateOutputText.value =
                                await translateFunction(
                                  getxObj.selectedLanguageSource.value,
                                  getxObj.selectedLanguageDestination.value,
                                  getxObj.translateInputText.text,
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorsScheme.surface,
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(
                      color: const Color.fromARGB(68, 158, 158, 158),
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    Icons.compare_arrows,
                    size: 30,
                    color: getxObj.darkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorsScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(68, 158, 158, 158),
                        width: 0.5,
                      ),
                    ),
                    // color: Colors.amber,
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          // menuWidth: 100,
                          isDense: true,
                          menuMaxHeight: 300,
                          value: getxObj.selectedLanguageDestination.value,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blueGrey,
                          ),
                          dropdownColor: colorsScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          items: DummyData.languagesList.map((value) {
                            return DropdownMenuItem(
                              value: value["name"],

                              child: Text(
                                value["name"],
                                selectionColor: Colors.white,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            getxObj.selectedLanguageDestination.value = value
                                .toString();
                            getxObj.translateOutputText.value =
                                await translateFunction(
                                  getxObj.selectedLanguageSource.value,
                                  getxObj.selectedLanguageDestination.value,
                                  getxObj.translateInputText.text,
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getxObj.darkMode.value
                            ? colorsScheme.surface
                            : const Color.fromARGB(69, 96, 125, 139),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(44, 158, 158, 158),
                          width: 0.5,
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: const Color.fromARGB(84, 96, 125, 139),
                        //     offset: Offset(0, 0),
                        //     blurRadius: 6,
                        //   ),
                        // ],
                      ),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SOURCE TEXT",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Obx(
                                () => Text(
                                  getxObj.selectedLanguageSource.value,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: getxObj.darkMode.value
                                  ? const Color.fromARGB(72, 96, 125, 139)
                                  : Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _fromKey,
                              child: TextFormField(
                                controller: getxController.translateInputText,
                                minLines: 7,
                                maxLines: 7,
                                onChanged: (value) {
                                  if (value.trim().isEmpty &&
                                      getxController
                                              .translateOutputText
                                              .value !=
                                          'Translation....') {
                                    getxController.translateOutputText.value =
                                        'Translation....';
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Fill the TextBox !!";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.blue,
                                focusNode: _inputBoxKey,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                  hintText: "Enter text to translate....",
                                  hintStyle: TextStyle(fontSize: 17),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: const Color.fromARGB(
                                        71,
                                        158,
                                        158,
                                        158,
                                      ),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: getxObj.darkMode.value
                                      ? const Color.fromARGB(60, 255, 153, 0)
                                      : Colors.deepOrangeAccent,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 7,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    Icon(
                                      Icons.paste,
                                      color: getxObj.darkMode.value
                                          ? Colors.orange
                                          : Colors.white,
                                    ),
                                    Text(
                                      "Paste",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: getxObj.darkMode.value
                                      ? Color.fromRGBO(43, 140, 238, 0.402)
                                      : Color.fromRGBO(43, 140, 238, 1),
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(300),
                                  ),
                                  minimumSize: Size.zero,
                                ),
                                onPressed: () async {
                                  Get.dialog(voiceToText());
                                  await _initSpeech();
                                },
                                child: Icon(
                                  Icons.mic,
                                  size: 22,
                                  color: getxObj.darkMode.value
                                      ? Color.fromRGBO(43, 140, 238, 1)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _inputBoxKey.unfocus();
                          getxObj.translateOutputText.value =
                              await translateFunction(
                                getxObj.selectedLanguageSource.value,
                                getxObj.selectedLanguageDestination.value,
                                getxObj.translateInputText.text,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(43, 140, 238, 1),
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size.zero,
                          alignment: Alignment.center,
                        ),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.translate,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              "Translate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: getxObj.darkMode.value
                            ? Color.fromRGBO(91, 129, 167, 0.23)
                            : const Color.fromARGB(69, 96, 125, 139),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(68, 158, 158, 158),
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TRANSLATION",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    getxObj.selectedLanguageDestination.value,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            constraints: BoxConstraints(minHeight: 145),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: getxObj.darkMode.value
                                    ? Color.fromRGBO(91, 129, 167, 0.266)
                                    : Colors.white,
                                padding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size.zero,
                                alignment: Alignment.topLeft,
                              ),
                              child: Obx(
                                () => Text(
                                  getxObj.translateOutputText.value,
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 0.5,
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: getxObj.darkMode.value
                                  ? Color.fromRGBO(23, 34, 48, 1)
                                  : Colors.blueGrey,
                            ),
                            child: Row(
                              children: [
                                _optionFunction(Icons.volume_up, "LISTEN"),
                                _optionFunction(Icons.copy, "COPY"),
                                _optionFunction(Icons.share, "SHARE"),
                                _optionFunction(Icons.clear, "CLEAR"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Divider(color: Colors.blueGrey, height: 0.5),
                        ),
                        Text(
                          "Translate by Ai",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Expanded(
                          child: Divider(color: Colors.blueGrey, height: 0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionFunction(iconValue, textValue) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (textValue == 'LISTEN') {
            await tts.speakText(
              getxObj.translateOutputText.value == 'Translation....'
                  ? 'Please Enter Source Text'
                  : getxObj.translateOutputText.value,
            );
          } else if (getxObj.translateInputText.text.trim().isEmpty) {
            showSnackbarFunction(
              context,
              "Please fill Source Text!!",
              Colors.red,
              Icons.info,
            );
          } else if (textValue == 'COPY') {
            Clipboard.setData(
              ClipboardData(text: getxObj.translateOutputText.value),
            );
          } else if (textValue == 'SHARE') {
            final result = await SharePlus.instance.share(
              ShareParams(
                title:
                    "Translated Text from ${getxObj.selectedLanguageSource.value} to ${getxObj.selectedLanguageDestination.value}:",
                text: getxObj.translateOutputText.value,
              ),
            );
            if (result.status == ShareResultStatus.success) {
              showSnackbarFunction(
                context,
                "Share Successfully!!",
                Colors.blue,
                Icons.done,
              );
            }
          } else {
            log("message");
            getxObj.translateOutputText.value = 'Translation....';
            getxObj.translateInputText.clear();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: textValue == "CLEAR"
                  ? BorderSide.none
                  : BorderSide(
                      color: getxObj.darkMode.value
                          ? Colors.blueGrey
                          : Colors.white,
                      width: 0.5,
                    ),
            ),
          ),
          child: Column(
            spacing: 3,
            children: [
              Icon(
                iconValue,
                color: textValue == "CLEAR"
                    ? Colors.red
                    : getxObj.darkMode.value
                    ? Colors.blueGrey
                    : Colors.white,
                size: 23,
              ),
              Text(
                textValue,
                style: TextStyle(
                  color: textValue == "CLEAR"
                      ? Colors.red
                      : getxObj.darkMode.value
                      ? Colors.blueGrey
                      : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget voiceToText() {
  final getxObj = Get.find<getController>();
  return Stack(
    alignment: Alignment.center,
    children: [
      OrbitBubbles(),
      AvatarGlow(
        glowColor: DummyData
            .backgroundColorsAi[getxObj.backgroundColorsAssistanceGetx.value],
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
          child: Icon(Icons.mic, color: Colors.white, size: 32),
        ),
      ),
    ],
  );
}
