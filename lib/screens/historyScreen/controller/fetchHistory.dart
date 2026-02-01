// import 'dart:developer';

import 'dart:developer';

import 'package:get/get.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/getxController.dart';

Future historyFetch(userId, historyType) async {
  final getxObj = Get.find<getController>();
  var data;
  try {
    if (historyType == "Scanner History") {
      data = await readScnnerHistory(userId);
    } else if (historyType == "Chat History") {
      data = await readChatHistory(userId);
    } else if (historyType == "Voice History") {
      log("message");
      data = await readVoiceHistory(userId);
    }
    // log(data.toString());
    if (data != null) {
      getxObj.historyData.assignAll(data);
      getxObj.searchHistory.assignAll(data);
    }
  } catch (err) {
    log(err.toString());
  }
}
