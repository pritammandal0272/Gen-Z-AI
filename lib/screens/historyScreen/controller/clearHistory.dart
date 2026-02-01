import 'dart:developer';

import 'package:get/get.dart';
import 'package:voice_assistant/controller/dataBase/deleteRow.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/getxController.dart';

Future<bool> clearAlHistory(userId, historyType) async {
  final getxObj = Get.find<getController>();
  var data;
  var readData = [];
  try {
    if (historyType == "Scanner History") {
      readData = await readScnnerHistory(userId);
      if (readData.isEmpty) {
        return false;
      }
      data = await deleteChatHistory(userId, "scanerHistory");
    } else if (historyType == "Chat History") {
      readData = await readChatHistory(userId);
      if (readData.isEmpty) {
        return false;
      }
      data = await deleteChatHistory(userId, "chatHistory");
    } else if (historyType == "Voice History") {
      readData = await readScnnerHistory(userId);
      if (readData.isEmpty) {
        return false;
      }
      data = await deleteChatHistory(userId, "voiceHistory");
    }
    // log(data.toString());
    getxObj.historyData.clear();
    getxObj.searchHistory.clear();
  } catch (err) {
    log(err.toString());
  }

  return data;
}
