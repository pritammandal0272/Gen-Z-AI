import 'dart:io';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:rainbow_edge_lighting/rainbow_edge_lighting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/scannerScreen/view/AiScanner.dart';
import 'package:voice_assistant/screens/chatScreen/view/chatScreen.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/screens/toolsScreen.dart';
import 'package:voice_assistant/screens/translateScreen.dart';
import 'package:voice_assistant/screens/voiceScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';
import 'package:voice_assistant/widgets/speakingBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getxObj = Get.find<getController>();
  final List<TextEditingController> textBoxValue = [];
  final List<GlobalKey<FormState>> _fromKey = [];
  final List<FocusNode> _textFocus = [];
  final GlobalKey<FormState> _fromKeyChat = GlobalKey();
  final FocusNode _textFocusChat = FocusNode();
  final TextEditingController _textChatController = TextEditingController();
  @override
  void initState() {
    int listLength = DummyData.suggestiveQuestion["All"].length;
    for (int i = 0; i < listLength; i++) {
      textBoxValue.add(TextEditingController());
      _fromKey.add(GlobalKey<FormState>());
      _textFocus.add(FocusNode());
    }
    super.initState();
  }

  @override
  void dispose() {
    int listLength = DummyData.suggestiveQuestion["All"].length;
    for (int i = 0; i < listLength; i++) {
      _fromKey[i].currentState?.reset();
      _textFocus[i].unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 3,
              children: [
                CircleAvatar(
                  minRadius: 10,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/sunLight.png"),
                ),
                Text(
                  "Good Afternoon",
                  style: TextStyle(fontSize: 16, color: colorsScheme.secondary),
                ),
              ],
            ),
            Text(
              getxObj.logInUserData.isNotEmpty
                  ? getxObj.logInUserData[0]["UserName"]
                  : "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorsScheme.secondary,
              ),
            ),
          ],
        ),
        titleSpacing: 15,
        actions: [
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                ShowPopover(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: colorsScheme.secondary, width: 2),
                  borderRadius: BorderRadius.circular(300),
                ),
                child: Obx(
                  () => CircleAvatar(
                    backgroundColor: const Color.fromARGB(52, 96, 125, 139),
                    backgroundImage:
                        getxObj.logInUserData.isNotEmpty &&
                            getxObj.logInUserData[0]["Photo"] == ""
                        ? AssetImage("assets/userLogo.png")
                        : getxObj.logInUserData.isNotEmpty
                        ? FileImage(File(getxObj.logInUserData[0]["Photo"]))
                        : null,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            height: 0.5,
            decoration: BoxDecoration(
              // color: Color.fromRGBO(16, 19, 34, 1),
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
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 100),
            // margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorsScheme.tertiaryContainer,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(54, 96, 125, 139),
                            offset: Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],

                        border: Border(
                          bottom: BorderSide(
                            color: const Color.fromARGB(71, 96, 125, 139),
                          ),
                          left: BorderSide(
                            color: const Color.fromARGB(71, 96, 125, 139),
                            width: 1,
                          ),
                          right: BorderSide(
                            color: const Color.fromARGB(71, 96, 125, 139),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage("assets/appLogo.png"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      "GEN-Z AI ASSISTANCE",
                                      textAlign: TextAlign.left,

                                      speed: const Duration(milliseconds: 110),
                                      textStyle: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1,
                                        color: getxObj.darkMode.value
                                            ? Colors.white
                                            : Colors.teal,
                                        shadows: [
                                          Shadow(
                                            color: getxObj.darkMode.value
                                                ? Colors.black.withOpacity(0.7)
                                                : Colors.transparent,
                                            blurRadius: 22,
                                            offset: const Offset(0, 10),
                                          ),
                                          Shadow(
                                            color: const Color(
                                              0xFF4FC3F7,
                                            ).withOpacity(0.45),
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
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, left: 15, right: 15),
                      height: 250,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                        color: colorsScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromARGB(71, 96, 125, 139),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(54, 96, 125, 139),
                            offset: Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 28,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        spacing: 7,
                                        children: [
                                          AvatarGlow(
                                            glowColor: Colors.greenAccent,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color.fromARGB(
                                                  209,
                                                  105,
                                                  240,
                                                  175,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "AI ONLINE",
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Command Center",
                                        style: TextStyle(
                                          color: colorsScheme.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 27,
                                        child: Row(
                                          spacing: 7,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                  48,
                                                  174,
                                                  31,
                                                  0.264,
                                                ),
                                                elevation: 0,
                                                minimumSize: Size.zero,

                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                    48,
                                                    174,
                                                    31,
                                                    1,
                                                  ),
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor:
                                                    colorsScheme.secondary,
                                              ),

                                              onPressed: () {
                                                Get.to(
                                                  () => ChatScreen(
                                                    dataFromAiSkills: {
                                                      "type": "home",
                                                      "data": "",
                                                    },
                                                  ),
                                                  transition: Transition.zoom,
                                                );
                                              },
                                              child: Row(
                                                spacing: 3,
                                                children: [
                                                  Icon(
                                                    Icons.sms,
                                                    size: 15,
                                                    color:
                                                        getxObj.darkMode.value
                                                        ? Colors.white
                                                        : Color.fromRGBO(
                                                            48,
                                                            174,
                                                            31,
                                                            1,
                                                          ),
                                                  ),
                                                  Text(
                                                    "TEXT",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      height: 1,
                                                      color:
                                                          getxObj.darkMode.value
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              48,
                                                              174,
                                                              31,
                                                              1,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    getxObj.darkMode.value
                                                    ? const Color.fromRGBO(
                                                        28,
                                                        30,
                                                        46,
                                                        1,
                                                      )
                                                    : Color.fromRGBO(
                                                        31,
                                                        55,
                                                        174,
                                                        0.245,
                                                      ),

                                                elevation: 0,
                                                minimumSize: Size.zero,

                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                    31,
                                                    55,
                                                    174,
                                                    1,
                                                  ),
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor:
                                                    colorsScheme.secondary,
                                              ),

                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.noHeader,
                                                  animType: AnimType.scale,
                                                  padding: EdgeInsets.zero,
                                                  showCloseIcon: true,
                                                  dialogBackgroundColor:
                                                      Colors.transparent,
                                                  width: MediaQuery.of(
                                                    context,
                                                  ).size.width,
                                                  closeIcon: Icon(
                                                    Icons.close_sharp,
                                                    size: 17,
                                                    color: Colors.red,
                                                  ),
                                                  bodyHeaderDistance: 0,
                                                  body: VoiceScreen(),
                                                ).show();
                                              },
                                              child: Row(
                                                spacing: 3,
                                                children: [
                                                  Icon(
                                                    Icons.graphic_eq,
                                                    size: 15,
                                                    color:
                                                        getxObj.darkMode.value
                                                        ? Colors.white
                                                        : Color.fromRGBO(
                                                            31,
                                                            55,
                                                            174,
                                                            1,
                                                          ),
                                                  ),
                                                  Text(
                                                    "VOICE",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      height: 1,
                                                      color:
                                                          getxObj.darkMode.value
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              31,
                                                              55,
                                                              174,
                                                              1,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 27,
                                        child: Row(
                                          spacing: 7,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    getxObj.darkMode.value
                                                    ? const Color.fromRGBO(
                                                        28,
                                                        30,
                                                        46,
                                                        1,
                                                      )
                                                    : Color.fromRGBO(
                                                        31,
                                                        55,
                                                        174,
                                                        0.245,
                                                      ),
                                                elevation: 0,
                                                minimumSize: Size.zero,

                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                    31,
                                                    55,
                                                    174,
                                                    1,
                                                  ),
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor:
                                                    colorsScheme.secondary,
                                              ),

                                              onPressed: () {
                                                Get.to(
                                                  () => TranslateScreen(),
                                                  transition: Transition.zoom,
                                                );
                                              },
                                              child: Row(
                                                spacing: 3,
                                                children: [
                                                  Icon(
                                                    Icons.translate,
                                                    size: 15,
                                                    color:
                                                        getxObj.darkMode.value
                                                        ? Colors.white
                                                        : Color.fromRGBO(
                                                            31,
                                                            55,
                                                            174,
                                                            1,
                                                          ),
                                                  ),
                                                  Text(
                                                    "TRANSLATE",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      height: 1,
                                                      color:
                                                          getxObj.darkMode.value
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              31,
                                                              55,
                                                              174,
                                                              1,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                  48,
                                                  174,
                                                  31,
                                                  0.264,
                                                ),
                                                elevation: 0,
                                                minimumSize: Size.zero,

                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                    48,
                                                    174,
                                                    31,
                                                    1,
                                                  ),
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor:
                                                    colorsScheme.secondary,
                                              ),

                                              onPressed: () {
                                                Get.to(
                                                  () => AiScanner(
                                                    data: {"imageURL": ""},
                                                  ),
                                                  transition: Transition.zoom,
                                                );
                                              },
                                              child: Row(
                                                spacing: 3,
                                                children: [
                                                  Obx(
                                                    () => Icon(
                                                      Icons
                                                          .qr_code_scanner_outlined,
                                                      size: 15,
                                                      color:
                                                          getxObj.darkMode.value
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              48,
                                                              174,
                                                              31,
                                                              1,
                                                            ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "SCAN",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      height: 1,
                                                      color:
                                                          getxObj.darkMode.value
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              48,
                                                              174,
                                                              31,
                                                              1,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: -120,
                                  top: 16,
                                  child: Column(
                                    children: [
                                      SpeakingBox(
                                        hightBox: 200,
                                        isBottomtextShow: true,
                                        isHomeScreen: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 63,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(
                              bottom: 1,
                              left: 1,
                              right: 1,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: const Color.fromARGB(
                                    80,
                                    158,
                                    158,
                                    158,
                                  ),
                                  width: 0.5,
                                ),
                              ),
                              color: Color.fromRGBO(
                                31,
                                55,
                                174,
                                1,
                              ).withOpacity(0.20),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Form(
                                    key: _fromKeyChat,
                                    child: TextFormField(
                                      controller: _textChatController,
                                      focusNode: _textFocusChat,
                                      style: TextStyle(
                                        color: colorsScheme.secondary,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Ready for input...",

                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: colorsScheme.onSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(
                                      48,
                                      174,
                                      31,
                                      0.177,
                                    ),
                                    elevation: 0,
                                    minimumSize: Size.zero,

                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    side: BorderSide(
                                      color: Color.fromRGBO(48, 174, 31, 1),
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    foregroundColor: colorsScheme.secondary,
                                  ),

                                  onPressed: () {
                                    if (_textChatController.text
                                        .trim()
                                        .isEmpty) {
                                      showSnackbarFunction(
                                        context,
                                        "Please enter Text!!",
                                        Colors.red,
                                        Icons.info,
                                      );
                                    } else {
                                      final DateTime time = DateTime.now();
                                      var now = DateFormat.jm().format(time);
                                      final dataFromUser = {
                                        "id": 0,
                                        "role": "user",
                                        "message": _textChatController.text,
                                        "time": now.toString(),
                                      };
                                      _textChatController.clear();
                                      _fromKeyChat.currentState?.reset();
                                      _textFocusChat.unfocus();
                                      Get.to(
                                        () => ChatScreen(
                                          dataFromAiSkills: {
                                            "type": true,
                                            "data": dataFromUser,
                                          },
                                        ),
                                        transition: Transition.zoom,
                                      );
                                    }
                                  },
                                  child: Row(
                                    spacing: 3,
                                    children: [
                                      Icon(
                                        Icons.sms,
                                        size: 16,
                                        color: getxObj.darkMode.value
                                            ? Colors.white
                                            : Color.fromRGBO(48, 174, 31, 1),
                                      ),
                                      Text(
                                        "Start Chat",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          height: 1.2,
                                          color: getxObj.darkMode.value
                                              ? Colors.white
                                              : Color.fromRGBO(48, 174, 31, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      SizedBox(height: 2),
                      Text(
                        "CORE ACTIONS",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => ChatScreen(
                                    dataFromAiSkills: {
                                      "type": false,
                                      "data": "",
                                    },
                                  ),
                                  transition: Transition.zoom,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                height: 130,
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  // border: BoxBorder.all(
                                  //   color: Colors.grey.withAlpha(80),
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(96, 165, 250, 1),
                                      offset: Offset(0, 0),
                                      blurRadius: getxObj.darkMode.value
                                          ? 0.5
                                          : 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 7,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        minimumSize: Size.zero,
                                        backgroundColor: Color.fromRGBO(
                                          96,
                                          165,
                                          250,
                                          0.373,
                                        ),
                                        iconSize: 26,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          side: BorderSide(
                                            color: Color.fromRGBO(
                                              96,
                                              165,
                                              250,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Icon(
                                        Icons.chat_outlined,
                                        color: Color.fromRGBO(96, 165, 250, 1),
                                      ),
                                    ),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Chat with Ai",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: colorsScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "Text based Assist",
                                          style: TextStyle(
                                            color: colorsScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.noHeader,
                                  animType: AnimType.scale,
                                  padding: EdgeInsets.zero,
                                  showCloseIcon: true,
                                  dialogBackgroundColor: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  closeIcon: Icon(
                                    Icons.close_sharp,
                                    size: 17,
                                    color: Colors.red,
                                  ),
                                  bodyHeaderDistance: 0,
                                  body: VoiceScreen(),
                                ).show();
                              },
                              child: Container(
                                height: 130,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purpleAccent,
                                      offset: Offset(0, 0),
                                      blurRadius: getxObj.darkMode.value
                                          ? 0.5
                                          : 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 7,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        minimumSize: Size.zero,
                                        backgroundColor: const Color.fromARGB(
                                          36,
                                          223,
                                          64,
                                          251,
                                        ),
                                        iconColor: Colors.purpleAccent,
                                        iconSize: 26,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          side: BorderSide(
                                            color: const Color.fromARGB(
                                              187,
                                              223,
                                              64,
                                              251,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Icon(Icons.mic),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Talk with Ai",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: colorsScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "Natural Conversition",
                                          style: TextStyle(
                                            color: colorsScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => TranslateScreen(),
                                  transition: Transition.zoom,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                height: 130,
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(34, 211, 238, 1),
                                      offset: Offset(0, 0),
                                      blurRadius: getxObj.darkMode.value
                                          ? 0.5
                                          : 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 7,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        minimumSize: Size.zero,
                                        backgroundColor: Color.fromRGBO(
                                          34,
                                          211,
                                          238,
                                          0.308,
                                        ),
                                        iconColor: Color.fromRGBO(
                                          34,
                                          211,
                                          238,
                                          1,
                                        ),
                                        elevation: 0,
                                        iconSize: 26,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          side: BorderSide(
                                            color: Color.fromRGBO(
                                              34,
                                              211,
                                              238,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Icon(Icons.translate),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Translate",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: colorsScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "Ai Translator",
                                          style: TextStyle(
                                            color: colorsScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => AiScanner(data: {"imageURL": ""}),
                                  transition: Transition.zoom,
                                );
                              },
                              child: Container(
                                height: 130,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(53, 216, 156, 1),
                                      offset: Offset(0, 0),
                                      blurRadius: getxObj.darkMode.value
                                          ? 0.5
                                          : 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 7,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        minimumSize: Size.zero,
                                        backgroundColor: Color.fromRGBO(
                                          0,
                                          255,
                                          85,
                                          0.249,
                                        ),
                                        iconColor: Color.fromRGBO(
                                          53,
                                          216,
                                          156,
                                          1,
                                        ),
                                        elevation: 0,
                                        iconSize: 26,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          side: BorderSide(
                                            color: Color.fromRGBO(
                                              53,
                                              216,
                                              156,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      label: Icon(Icons.qr_code_scanner),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Scanner",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: colorsScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "Scan Text or Images",
                                          style: TextStyle(
                                            color: colorsScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "SMART QUICK ACTIONS",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          InkWell(
                            onTap: () => _smartQuickAction(
                              "Compose and Send an Email",
                              "Write and send professional emails easily",
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: colorsScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(228, 108, 171, 1),
                                    offset: Offset(0, 0),
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.all(10),
                                      minimumSize: Size.zero,
                                      backgroundColor: Color.fromRGBO(
                                        228,
                                        108,
                                        171,
                                        0.249,
                                      ),
                                      iconColor: Color.fromRGBO(
                                        228,
                                        108,
                                        171,
                                        1,
                                      ),
                                      iconSize: 26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        side: BorderSide(
                                          color: Color.fromRGBO(
                                            228,
                                            108,
                                            171,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    label: Icon(Icons.photo_camera_outlined),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Compose and Send an Email",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: colorsScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        "Write and send professional emails easily",
                                        style: TextStyle(
                                          color: colorsScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => _smartQuickAction(
                              "Generate Ideas",
                              "Get ideas and quick notes",
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colorsScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(237, 114, 26, 1),
                                    offset: Offset(0, 0),
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      minimumSize: Size.zero,
                                      elevation: 0,
                                      backgroundColor: Color.fromRGBO(
                                        237,
                                        114,
                                        26,
                                        0.249,
                                      ),
                                      iconColor: Color.fromRGBO(
                                        237,
                                        114,
                                        26,
                                        1,
                                      ),
                                      iconSize: 26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        side: BorderSide(
                                          color: Color.fromRGBO(
                                            237,
                                            114,
                                            26,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    label: Icon(Icons.lightbulb_outline),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Generate Ideas",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: colorsScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        "Get ideas and quick notes",
                                        style: TextStyle(
                                          color: colorsScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => _smartQuickAction(
                              "Plan Tasks",
                              "Create a simple task plan",
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: colorsScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                // border: BoxBorder.all(color: Colors.grey.withAlpha(80)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(37, 99, 235, 1),
                                    offset: Offset(0, 0),
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      minimumSize: Size.zero,
                                      elevation: 0,
                                      backgroundColor: Color.fromRGBO(
                                        37,
                                        99,
                                        235,
                                        0.249,
                                      ),
                                      iconColor: Color.fromRGBO(37, 99, 235, 1),
                                      iconSize: 26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        side: BorderSide(
                                          color: Color.fromRGBO(37, 99, 235, 1),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    label: Icon(Icons.task),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Plan Tasks",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: colorsScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        "Create a simple task plan",
                                        style: TextStyle(
                                          color: colorsScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PRODUCTIVITY FLOW",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => ToolsScreen(
                                  data: {"backbuttonPress": true},
                                ),
                                transition: Transition.rightToLeftWithFade,
                              );
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount:
                              DummyData.suggestiveQuestion["All"]?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 12,
                                    right: 10,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colorsScheme.surface,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: DummyData
                                          .suggestiveQuestion["All"]?[index]["color"]
                                          .withOpacity(0.5),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: DummyData
                                            .suggestiveQuestion["All"]?[index]["color"]
                                            .withOpacity(0.4),
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: -10,
                                        right: -10,
                                        child: Container(
                                          height: 140,

                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.25,
                                          child: ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                              sigmaX: 0,
                                              sigmaY: 0,
                                            ),
                                            child: Container(
                                              height: 140,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    80,
                                                  ),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: DummyData
                                                    .suggestiveQuestion["All"]?[index]["color"]
                                                    .withOpacity(0.10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Column(
                                        spacing: 5,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  padding: EdgeInsets.all(10),
                                                  minimumSize: Size.zero,
                                                  backgroundColor: DummyData
                                                      .suggestiveQuestion["All"]?[index]["color"]
                                                      .withOpacity(0.20),
                                                  iconColor: DummyData
                                                      .suggestiveQuestion["All"]?[index]["color"],
                                                  iconSize: 23,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          300,
                                                        ),
                                                    side: BorderSide(
                                                      color: DummyData
                                                          .suggestiveQuestion["All"]?[index]["color"]
                                                          .withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                label: Icon(
                                                  DummyData
                                                      .suggestiveQuestion["All"]?[index]["icon"],
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_outward,
                                                color: const Color.fromARGB(
                                                  166,
                                                  158,
                                                  158,
                                                  158,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DummyData
                                                    .suggestiveQuestion["All"]?[index]["title"],
                                                style: TextStyle(
                                                  color: colorsScheme.secondary,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                DummyData
                                                    .suggestiveQuestion["All"]?[index]["subTitle"],
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    156,
                                                    158,
                                                    158,
                                                    158,
                                                  ),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Form(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              key: _fromKey[index],

                                              child: TextFormField(
                                                controller: textBoxValue[index],
                                                minLines: 3,
                                                maxLines: 6,

                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return "Fill the TextBox !!";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: TextStyle(
                                                  color: colorsScheme.secondary,
                                                ),
                                                cursorColor: Colors.blue,

                                                textInputAction:
                                                    TextInputAction.newline,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                focusNode: _textFocus[index],
                                                decoration: InputDecoration(
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              15,
                                                            ),
                                                        borderSide: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                  hintText: "Type here...",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              15,
                                                            ),
                                                        borderSide: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    borderSide: BorderSide(
                                                      width: 0.5,
                                                      color:
                                                          const Color.fromARGB(
                                                            71,
                                                            158,
                                                            158,
                                                            158,
                                                          ),
                                                    ),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    borderSide: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  filled: true,

                                                  fillColor: DummyData
                                                      .suggestiveQuestion["All"]?[index]["color"]
                                                      .withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          SizedBox(
                                            height: 45,
                                            width: MediaQuery.of(
                                              context,
                                            ).size.width,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: DummyData
                                                    .suggestiveQuestion["All"]?[index]["color"]
                                                    .withOpacity(0.2),
                                                side: BorderSide(
                                                  color: DummyData
                                                      .suggestiveQuestion["All"]?[index]["color"]
                                                      .withOpacity(0.8),
                                                  width: 0.5,
                                                ),
                                                minimumSize: Size.zero,
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                ),
                                              ),
                                              onPressed: () {
                                                _submitButtonFunction(index);
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 7,
                                                children: [
                                                  Icon(
                                                    Icons.auto_awesome,
                                                    color: DummyData
                                                        .suggestiveQuestion["All"]?[index]["color"],
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    DummyData
                                                        .suggestiveQuestion["All"]?[index]["question"],
                                                    style: TextStyle(
                                                      color: DummyData
                                                          .suggestiveQuestion["All"]?[index]["color"],
                                                      fontSize: 15,
                                                    ),
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

                                // Positioned(
                                //   child: Container(
                                //     height: 60,
                                //     width:
                                //         MediaQuery.of(context).size.width * 0.55,
                                //     child: ImageFiltered(
                                //       imageFilter: ImageFilter.blur(
                                //         sigmaX: 80,
                                //         sigmaY: 80,
                                //       ),
                                //       child: Container(
                                //         height: 60,
                                //         width:
                                //             MediaQuery.of(context).size.width *
                                //             0.5,
                                //         decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(
                                //             300,
                                //           ),
                                //           color: const Color(
                                //             0xFF5B8CFF,
                                //           ).withOpacity(0.20),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),

                      RainbowEdgeLighting(
                        glowEnabled: false,
                        radius: 20,
                        thickness: 0.7,
                        speed: 0.5,
                        colors: const [
                          Color(0xFFFFCDD2),
                          Color(0xFFEF9A9A),
                          Color(0xFFE57373),
                          Color(0xFFF44336),
                          Color(0xFFFF7043),
                          Color(0xFFF44336),
                          Color(0xFFE57373),
                          Color(0xFFEF9A9A),
                        ],
                        clip: true,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 15,
                            bottom: 10,
                          ),
                          height: 150,
                          decoration: BoxDecoration(
                            color: colorsScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: BoxBorder.all(
                              color: colorsScheme.onSecondary.withAlpha(80),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(54, 96, 125, 139),
                                offset: Offset(0, 0),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              "Assistance Pro",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: colorsScheme.secondary,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                      251,
                                                      199,
                                                      70,
                                                      1,
                                                    ),
                                                    Color.fromRGBO(
                                                      249,
                                                      119,
                                                      24,
                                                      1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Text(
                                                "PREMIUM",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 2,
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Color.fromRGBO(
                                                239,
                                                132,
                                                45,
                                                1,
                                              ),
                                              size: 18,
                                            ),
                                            Text(
                                              "Unlock GPT-4 Access",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          spacing: 2,
                                          children: [
                                            Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Color.fromRGBO(
                                                239,
                                                132,
                                                45,
                                                1,
                                              ),
                                              size: 18,
                                            ),
                                            Text(
                                              "Unlimited Voice Access",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(
                                          186,
                                          255,
                                          81,
                                          0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Upgrade",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: colorsScheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Image.asset("assets/primium.png"),
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
          ),
        ),
      ),
    );
  }

  void _smartQuickAction(title, subTitle) {
    final DateTime time = DateTime.now();
    var now = DateFormat.jm().format(time);
    final dataFromUser = {
      "id": 0,
      "role": "user",
      "message": "$title...\n$subTitle",
      "time": now.toString(),
    };
    Get.to(
      () => ChatScreen(
        dataFromAiSkills: {"type": "aiSkills", "data": dataFromUser},
      ),
      transition: Transition.zoom,
    );
  }

  void _submitButtonFunction(index) {
    if (!_fromKey[index].currentState!.validate()) {
      return;
    }
    final DateTime time = DateTime.now();
    var now = DateFormat.jm().format(time);
    final dataFromUser = {
      "id": 0,
      "role": "user",
      "message":
          "${textBoxValue[index].text}\n\n${DummyData.suggestiveQuestion[getxObj.suggestiveQuestionOption.value]?[index]["question"]}",
      "time": now.toString(),
    };
    textBoxValue[index].clear();
    _fromKey[index].currentState?.reset();
    _textFocus[index].unfocus();
    Get.to(
      () => ChatScreen(dataFromAiSkills: {"type": true, "data": dataFromUser}),
      transition: Transition.zoom,
    );
  }
}

void ShowPopover(BuildContext context) async {
  final colorsSheme = Theme.of(context).colorScheme;
  final getxObj = Get.find<getController>();
  showPopover(
    backgroundColor: colorsSheme.surface,
    context: context,
    direction: PopoverDirection.bottom,
    width: 160,
    arrowHeight: 10,
    arrowWidth: 20,
    bodyBuilder: (context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getxObj.logInUserData.isNotEmpty &&
                  getxObj.logInUserData[0]["Email_or_Phone"] == ""
              ? ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.login, size: 20),
                  title: Text("Login"),
                  minLeadingWidth: 0,
                  horizontalTitleGap: 6,
                  onTap: () {
                    Navigator.pop(context);
                    showLoginBottomSheet(context);
                  },
                )
              : SizedBox(),

          getxObj.logInUserData.isNotEmpty &&
                  getxObj.logInUserData[0]["Email_or_Phone"] == ""
              ? ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person_add, size: 20),
                  minLeadingWidth: 0,
                  horizontalTitleGap: 6,
                  title: Text("SignUp"),
                  onTap: () {
                    Navigator.pop(context);
                    showSignUpBottomSheet(context);
                  },
                )
              : SizedBox(),
          getxObj.logInUserData.isNotEmpty &&
                  getxObj.logInUserData[0]["Email_or_Phone"] != ""
              ? ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  horizontalTitleGap: 6,
                  leading: Icon(Icons.logout, size: 20, color: Colors.red),
                  title: Text("Logout", style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    final sp = await SharedPreferences.getInstance();
                    await sp.remove("isEmail");
                    Navigator.pop(context);
                    Get.offAll(
                      () => LoginScreen(),
                      transition: Transition.zoom,
                    );
                    showSnackbarFunction(
                      context,
                      "Logout Successfully",
                      Colors.blue,
                      Icons.check_circle_outline,
                    );
                  },
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}
