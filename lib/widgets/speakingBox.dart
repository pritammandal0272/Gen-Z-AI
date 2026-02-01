import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rainbow_edge_lighting/rainbow_edge_lighting.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/voiceScreen.dart';
import 'package:voice_assistant/widgets/voiceWave.dart';

class SpeakingBox extends StatefulWidget {
  final int hightBox;
  final bool isBottomtextShow;
  final bool isHomeScreen;
  const SpeakingBox({
    super.key,
    required this.hightBox,
    required this.isBottomtextShow,
    required this.isHomeScreen,
  });

  @override
  State<SpeakingBox> createState() => _SpeakingBoxState();
}

class _SpeakingBoxState extends State<SpeakingBox> {
  @override
  Widget build(BuildContext context) {
    // final colorsScheme = Theme.of(context).colorScheme;
    final getxObj = Get.find<getController>();
    return Transform.translate(
      offset: Offset(0, widget.isBottomtextShow ? 0 : 90),
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: widget.hightBox.toDouble(),
        // decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              // child: import 'dart:ui';
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Center(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(
                          width: widget.hightBox.toDouble() - 4,
                          height: widget.hightBox.toDouble() - 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF5B8CFF).withOpacity(0.20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      widget.isBottomtextShow
                          ? AwesomeDialog(
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
                            ).show()
                          : null;
                    },
                    child: Container(
                      height: widget.hightBox.toDouble() - 90,
                      width: widget.hightBox.toDouble() - 90,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        border: Border.all(color: Colors.blueAccent, width: 1),
                      ),
                      child: RainbowEdgeLighting(
                        glowEnabled: true,
                        radius: 200,
                        thickness: 3,
                        speed: 0.5,

                        colors: smoothLoop(const [
                          Color(0xFF3B4CFF),
                          Color(0xFF5B3BFF),
                          Color(0xFF3B9DFF),
                        ]),
                        clip: false,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: widget.hightBox.toDouble() - 120,
                          height: widget.hightBox.toDouble() - 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(28, 30, 46, 1),
                          ),
                          alignment: Alignment.center,
                          child: widget.isBottomtextShow
                              ? Icon(
                                  Icons.graphic_eq,
                                  size: widget.isHomeScreen ? 30 : 60,
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: VoiceWave(),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: widget.isHomeScreen ? -10 : 0,
                    child: Transform.translate(
                      offset: Offset(
                        widget.isBottomtextShow
                            ? widget.isHomeScreen
                                  ? 4
                                  : 28
                            : 12,
                        7,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.isHomeScreen ? 10 : 15,
                          vertical: widget.isHomeScreen ? 4 : 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: widget.isHomeScreen
                              ? BorderRadius.circular(7)
                              : BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(31, 55, 174, 1),
                            width: 1,
                          ),
                          color: getxObj.darkMode.value
                              ? const Color.fromRGBO(28, 30, 46, 1)
                              : Color.fromRGBO(131, 149, 236, 1),
                        ),
                        child: Text(
                          widget.isBottomtextShow ? "TAP TO START" : "SPEAKING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.isHomeScreen ? 12 : 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // widget.isBottomtextShow
            //     ? Column(
            //         children: [
            //           Text(
            //             "Tap to interrupt or keep",
            //             style: TextStyle(
            //               color: Colors.blueGrey,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 14,
            //               height: 1,
            //             ),
            //           ),
            //           Text(
            //             "speaking naturally",
            //             style: TextStyle(
            //               color: Colors.blueGrey,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ],
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
