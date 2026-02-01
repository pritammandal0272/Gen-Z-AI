import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_edge_lighting/rainbow_edge_lighting.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/animatedTyping.dart';
import 'package:voice_assistant/screens/chatScreen/controller/chatSend.dart';
import 'package:voice_assistant/screens/chatScreen/controller/scrollConteroller.dart';

class BottomNavigation extends StatelessWidget {
  final inputController;
  final focusNode;
  final controller;
  const BottomNavigation({super.key,required this. inputController,required this. focusNode,this.controller});
  
  @override
  Widget build(BuildContext context) {
     final chatControllerGetx = Get.put(chatGetxController());
  final getxObj = Get.find<getController>();
   final colorsScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 70,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: getxObj.darkMode.value
                      ? const Color.fromARGB(111, 158, 158, 158)
                      : Color.fromRGBO(37, 100, 235, 0.474),
                ),
              ),
              color: colorsScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(54, 96, 125, 139),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(183, 96, 125, 139),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(300),
                    ),
                    side: BorderSide(
                      color: const Color.fromARGB(102, 223, 64, 251),
                    ),
                    minimumSize: Size.zero,
                    padding: EdgeInsets.all(5),
                  ),
                  child: Icon(Icons.add, size: 25),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: colorsScheme.surface,
                      borderRadius: BorderRadius.circular(300),
                      border: BoxBorder.all(color: Colors.black.withAlpha(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(34, 211, 238, 1),
                          offset: Offset(0, 0),
                          blurRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: inputController,
                        // onChanged: (value) {
                        //   inputBoxValue = value;
                        // },
                        focusNode: focusNode,
                        onTap: () {
                          Timer(Duration(seconds: 1), () {
                            autoScroll(controller,force: false);
                          });
                        },
                        cursorColor: Colors.white,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ask anything...",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(144, 158, 158, 158),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Obx(
                  () => chatControllerGetx.isTypingAnimateTypingChat.value
                      ? InkWell(
                          onTap: () {
                            stopTyping(controller);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(54, 96, 125, 139),
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(40, 49, 255, 1),
                                  Color.fromARGB(197, 59, 131, 246),
                                  Color.fromARGB(205, 6, 181, 212),
                                ],
                              ),

                              borderRadius: BorderRadius.circular(300),
                            ),

                            child: SizedBox(
                              width: 47,
                              height: 47,
                              // decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned.fill(
                                        child: Center(
                                          child: Container(
                                            width: 47,
                                            height: 47,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xFF5B8CFF,
                                              ).withOpacity(0.20),
                                            ),
                                          ),
                                        ),
                                      ),

                                      RainbowEdgeLighting(
                                        glowEnabled: false,

                                        radius: 300,
                                        thickness: 4,
                                        speed: 0.5,

                                        colors: smoothLoop(const [
                                          Color(0xFF3B4CFF),
                                          Color(0xFF5B3BFF),
                                          Color(0xFF3B9DFF),
                                        ]),
                                        clip: false,
                                        child: Container(
                                          width: 47,
                                          height: 47,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color.fromRGBO(
                                              28,
                                              30,
                                              46,
                                              1,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.stop,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(54, 96, 125, 139),
                                offset: Offset(0, 0),
                                blurRadius: 5,
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(40, 49, 255, 1),
                                Color.fromARGB(197, 59, 131, 246),
                                Color.fromARGB(205, 6, 181, 212),
                              ],
                            ),

                            borderRadius: BorderRadius.circular(300),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              chatSendFuntion(controller, context,inputController);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  300,
                                ),
                              ),
                              minimumSize: Size.zero,
                              padding: EdgeInsets.all(10),
                            ),
                            child: Icon(Icons.arrow_upward, size: 30),
                          ),
                        ),
                ),
                Obx(
                  () => chatControllerGetx.isTypingAnimateTypingChat.value
                      ? SizedBox(width: 3)
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}