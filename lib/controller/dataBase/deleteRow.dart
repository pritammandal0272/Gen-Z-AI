import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';

Future deleteValueDB() async {
  final dataBase = InitializeDatabase();
  dataBase.db.execute('''DELETE FROM ASSIATANCEAPPDATA WHERE UserId = 1''');
}

Future deleteChatHistory(userId,type) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute('''DELETE FROM $type WHERE userId = $userId''');
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}
