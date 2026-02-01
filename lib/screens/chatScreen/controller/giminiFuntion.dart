import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:voice_assistant/auth/giminiApi.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/animatedTyping.dart';
import 'package:voice_assistant/screens/chatScreen/controller/saveHistory.dart';
import 'package:voice_assistant/screens/chatScreen/controller/scrollConteroller.dart';

void callGiminiFunction(controller, value) async {
  final chatControllerGetx = Get.find<chatGetxController>();
  final getxObj = Get.find<getController>();
  await Future.delayed(Duration(microseconds: 600), () async {
    autoScroll(controller);
    // Gimini Response
    chatControllerGetx.isTypingChat.value = true;
    chatControllerGetx.isTypingAnimateTypingChat.value = true;
    chatControllerGetx.giminiReplyChatGetx.value = "";
    chatControllerGetx.chatData.add({
      "id": 0,
      "role": "ai",
      "message": "assets/animateTyping.gif",
      "time": "",
    });
    final giminiReply = await giminiData(value, "chat", "");
    var lastChatIndex = chatControllerGetx.chatData.length - 1;
    lastChatIndex = chatControllerGetx.chatData[lastChatIndex]["id"];
    final DateTime aiTime = DateTime.now();
    var now = DateFormat.jm().format(aiTime);
    final dataFromAi = {
      "id": lastChatIndex + 1,
      "role": "ai",
      "message": giminiReply,
      "time": now.toString(),
    };

    animateTypingText(controller, giminiReply);
    chatControllerGetx.chatData.removeLast();
    chatControllerGetx.isTypingChat.value = false;
    chatControllerGetx.chatData.add(dataFromAi);
    if (getxObj.logInUserData[0]["Email_or_Phone"] != "") {
      await saveChatHistory(
        getxObj.logInUserData[0]["UserId"],
        chatControllerGetx.chatData[((chatControllerGetx.chatData.length) -
            2)]["message"],
        giminiReply,
        DateFormat('MM/dd/yyyy h:mm a').format(aiTime),
      );
    }
    autoScroll(controller);
  });
}
