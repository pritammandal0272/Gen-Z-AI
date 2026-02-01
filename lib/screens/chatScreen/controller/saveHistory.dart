import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/insertValueDB.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';

Future saveChatHistory(userId, userSms, aiReply, date) async {
  if (aiReply != "Server Running Slow Please try again Later...") {
    log("$userId, $userSms, $aiReply, $date");

    await insertChatHistory(
      userId as int,
      userSms.toString(),
      aiReply.toString(),
      date.toString(),
    );
    read_all_DB_values();
  }
}
