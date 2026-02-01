// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/controller/formatGiminiText.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/initStateFunction.dart';
import 'package:voice_assistant/screens/chatScreen/widget/bottomNavigation.dart';
import 'package:voice_assistant/screens/historyScreen/view/historyScreen.dart';
import 'package:voice_assistant/screens/homeScreen.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> dataFromAiSkills;
  const ChatScreen({super.key, required this.dataFromAiSkills});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatControllerGetx = Get.put(chatGetxController());
  final getxObj = Get.find<getController>();
  final _focusNode = FocusNode();
  final _scrollConteoller = ScrollController();

  @override
  void initState() {
    initStateFunction(_scrollConteoller, widget.dataFromAiSkills);
    super.initState();
  }

  @override
  void dispose() {
    // _saveChatHistory();
    _focusNode.dispose();
    super.dispose();
  }

  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Color subBoxColor = Color.fromRGBO(3, 5, 15, 1);
    // final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Chat with Ai",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Online",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
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
                  Get.off(
                    () => HistoryScreen(historyType: "Chat History",),
                    transition: Transition.rightToLeft,
                  );
                }
              },
              child: Icon(Icons.history),
            ),
          ),
          SizedBox(width: 10),
        ],

        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Obx(
          () => ListView.builder(
            itemCount: chatControllerGetx.chatData.length,
            controller: _scrollConteoller,
            itemBuilder: (context, index) {
              final chatData = chatControllerGetx.chatData[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  spacing: 25,
                  children: [
                    SizedBox(height: 0),
                    chatData["role"] == "ai"
                        ? Stack(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            clipBehavior: Clip.none,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding:
                                      // chatControllerGetx.isTypingChat.value
                                      // ? EdgeInsets.all(5)
                                      // :
                                      EdgeInsets.only(
                                        left: 13,
                                        right: chatData["message"].length > 5
                                            ? 30
                                            : 50,
                                        top: 10,
                                        bottom: 28,
                                      ),
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        getxObj.darkMode.value &&
                                            getxObj
                                                    .backgroundColorsAiGetx
                                                    .value ==
                                                0
                                        ? Colors.black
                                        : DummyData.backgroundColorsAi[getxObj
                                              .backgroundColorsAiGetx
                                              .value],
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      color:
                                          getxObj.darkMode.value &&
                                              getxObj
                                                      .backgroundColorsAiGetx
                                                      .value ==
                                                  0
                                          ? const Color.fromARGB(
                                              80,
                                              96,
                                              125,
                                              139,
                                            )
                                          : const Color.fromARGB(
                                              206,
                                              250,
                                              253,
                                              255,
                                            ),
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          54,
                                          96,
                                          125,
                                          139,
                                        ),
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      chatControllerGetx.isTypingChat.value &&
                                              (index ==
                                                  chatControllerGetx
                                                          .chatData
                                                          .length -
                                                      1)
                                          ? Image.asset(
                                              chatData["message"],
                                              height: 30,
                                            )
                                          : chatControllerGetx
                                                    .isTypingAnimateTypingChat
                                                    .value &&
                                                index ==
                                                    chatControllerGetx
                                                            .chatData
                                                            .length -
                                                        1
                                          ? Obx(
                                              () => formatGiminiText(
                                                chatControllerGetx
                                                    .giminiReplyChatGetx
                                                    .value,
                                                getxObj.textSizeAiGetx.value,
                                                getxObj.chatBoldAiText.value,
                                              ),
                                            )
                                          : formatGiminiText(
                                              chatData["message"],
                                              getxObj.textSizeAiGetx.value,
                                              getxObj.chatBoldAiText.value,
                                            ),

                                      Positioned(
                                        right: chatData["message"].length > 5
                                            ? -20
                                            : -40,
                                        bottom: -20,
                                        child: Obx(
                                          () =>
                                              chatControllerGetx
                                                      .isTypingAnimateTypingChat
                                                      .value &&
                                                  index ==
                                                      chatControllerGetx
                                                              .chatData
                                                              .length -
                                                          1
                                              ? SizedBox()
                                              : Text(
                                                  chatData["time"],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -2,
                                top: -28,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "assets/logo.png",
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: chatData["message"].length > 5
                                          ? 30
                                          : 50,
                                      top: 7,
                                      bottom: 28,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors:
                                            DummyData.gradientColorsUser[getxObj
                                                .backgroundColorsUserGetx
                                                .value],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      border: BoxBorder.all(
                                        color: const Color.fromARGB(
                                          170,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                            54,
                                            96,
                                            125,
                                            139,
                                          ),
                                          offset: Offset(0, 0),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Text(
                                          chatData["message"],
                                          style: TextStyle(
                                            color:
                                                DummyData.textColorsAi[getxObj
                                                    .textColorsUserGetx
                                                    .value],
                                            fontWeight:
                                                getxObj.chatBoldUserText.value
                                                ? FontWeight.bold
                                                : null,
                                          ),
                                        ),
                                        Positioned(
                                          right: chatData["message"].length > 5
                                              ? -20
                                              : -40,
                                          bottom: -20,
                                          child: Text(
                                            chatData["time"],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(2, 15),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "assets/userLogo.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigation(
        inputController: _inputController,
        focusNode: _focusNode,
        controller: _scrollConteoller,
      ),
    );
  }
}
