import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';

Future insertValueDB(name, email, password, photo) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute(
      '''INSERT INTO ASSIATANCEAPPDATA(UserName,Password,Email_or_Phone,Photo) VALUES('$name','$password','$email','$photo')''',
    );
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}

Future<bool> insertChatHistory(
  int userId,
  String userSms,
  String aiReply,
  String date,
) async {
  final dataBase = InitializeDatabase();
  final db = dataBase.db;

  try {
    final result = db.prepare('''
      INSERT INTO chatHistory(userId, userSms, aiReply, date)
      VALUES(?, ?, ?, ?)
      ''');

    result.execute([userId, userSms, aiReply, date]);
    result.dispose();

    return true;
  } catch (e) {
    log("DB ERROR: $e");
    return false;
  }
}
Future<bool> insertScannerHistory(
  int userId,
  String imagePath,
  String aiReply,
  String date,
) async {
  final dataBase = InitializeDatabase();
  final db = dataBase.db;

  try {
    final result = db.prepare('''
      INSERT INTO scanerHistory(userId, imageURL, aiScanerReply, date)
      VALUES(?, ?, ?, ?)
      ''');

    result.execute([userId, imagePath, aiReply, date]);
    result.dispose();

    return true;
  } catch (e) {
    log("DB ERROR: $e");
    return false;
  }
}
Future<bool> insertVoiceHistory(
  int userId,
  String userVoice,
  String aiVoiceReply,
  String date,
) async {
  final dataBase = InitializeDatabase();
  final db = dataBase.db;

  try {
    final result = db.prepare('''
      INSERT INTO voiceHistory(userId, userVoice, aiVoiceReply, date)
      VALUES(?, ?, ?, ?)
      ''');

    result.execute([userId, userVoice, aiVoiceReply, date]);
    result.dispose();

    return true;
  } catch (e) {
    log("DB ERROR: $e");
    return false;
  }
}

