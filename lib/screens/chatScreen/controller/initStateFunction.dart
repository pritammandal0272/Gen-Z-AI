// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voice_assistant/controller/chatController.dart';
import 'package:voice_assistant/screens/chatScreen/controller/giminiFuntion.dart';
import 'package:voice_assistant/screens/chatScreen/controller/scrollConteroller.dart';

void initStateFunction(controller, dataFromAiSkills) {
  final chatControllerGetx = Get.find<chatGetxController>();
  autoScroll(controller, force: false);
  if (dataFromAiSkills["type"] == "history") {
    log(dataFromAiSkills["data"].toString());
    var time = dataFromAiSkills["data"]["date"].split(" ");
    time = "${time[1]} ${time[2]}";
    log(time.toString());
    final data = [
      {
        "id": 0,
        "role": "user",
        "message": dataFromAiSkills["data"]["userSms"],
        "time": time,
      },
      {
        "id": 0,
        "role": "ai",
        "message": dataFromAiSkills["data"]["aiReply"],
        "time": time,
      },
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatControllerGetx.chatData.addAll(data);
    });
  } else if (dataFromAiSkills["type"] == "aiSkills") {
    final data = [
      {
        "id": 0,
        "role": "user",
        "message": dataFromAiSkills["data"]["message"],
        "time": dataFromAiSkills["data"]["time"],
      },
    ];
    chatControllerGetx.chatData.addAll(data);
    callGiminiFunction(controller, dataFromAiSkills["data"]["message"]);
  } else {
    final data = [
      {
        "id": 0,
        "role": "ai",
        "message": "Hello there 👋 How can I help you today?",
        "time": "10:01 AM",
      },
    ];
    chatControllerGetx.chatData.addAll(data);
  }
}
