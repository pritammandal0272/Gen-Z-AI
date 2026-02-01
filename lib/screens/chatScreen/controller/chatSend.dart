import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:intl/intl.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/giminiFuntion.dart';
import 'package:voice_assistant/screens/chatScreen/controller/scrollConteroller.dart';
import 'package:voice_assistant/widgets/snackBar.dart';
void chatSendFuntion(controller,context,_inputController) async {
final chatControllerGetx =  Get.find<chatGetxController>();
    if (_inputController.text == "") {
      return showSnackbarFunction(
        context,
        "Empty Text Box!!",
        Colors.red,
        Icons.info,
      );
    } else {
      int lastChatIndex = chatControllerGetx.chatData.length - 1;
      lastChatIndex = chatControllerGetx.chatData[lastChatIndex]["id"];
      final DateTime time = DateTime.now();
      var now = DateFormat.jm().format(time);
      final dataFromUser = {
        "id": lastChatIndex + 1,
        "role": "user",
        "message": _inputController.text,
        "time": now.toString(),
      };
      await Future.delayed(Duration(microseconds: 600), () async {
        chatControllerGetx.chatData.add(dataFromUser);
        final chatData = _inputController.text;
        _inputController.clear();
        autoScroll(controller);

        // Gimini Response
        callGiminiFunction(controller,chatData);
      });
    }
  }