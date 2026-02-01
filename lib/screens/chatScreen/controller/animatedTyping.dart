import 'dart:async';

import 'package:get/get.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/scrollConteroller.dart';
Timer? _timer;
  void animateTypingText(controller,String stringValue) {
 final chatControllerGetx =  Get.find<chatGetxController>();
    _timer?.cancel();
    int index = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      if (index < stringValue.length) {
        chatControllerGetx.giminiReplyChatGetx.value += stringValue[index];
        index++;

        autoScroll(controller,force: true);
      } else {
        chatControllerGetx.isTypingAnimateTypingChat.value = false;
        _timer?.cancel();
      }
    });
  }

  void stopTyping(controller) {
    final chatControllerGetx =  Get.find<chatGetxController>();
    _timer?.cancel();
    chatControllerGetx.isTypingAnimateTypingChat.value = false;
    autoScroll(controller,force: true);
  }