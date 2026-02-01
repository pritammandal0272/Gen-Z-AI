import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';

Future UpdateAssistSettings(
  email,
  voice,
  language,
  fontSize,
  fontBold,
  bgColor,
  textColor,
  mode,
) async {
  final dataBase = InitializeDatabase();
  dataBase.db.execute(
    "UPDATE ASSIATANCEAPPDATA SET Output_Voice = $voice, Output_Language = '$language',Assist_FontSize = $fontSize,Assist_FontBold = $fontBold,Assist_bgColor = $bgColor,Assist_textColor = $textColor,SelectMode = '$mode' WHERE Email_or_Phone = '$email'",
  );
}

Future updateChatSettings(
  email,
  aiFontSize,
  aiFontBold,
  aiBgColor,
  userFontSize,
  userFontBold,
  userBgColor,
  userTextColor,
) async {
  final dataBase = InitializeDatabase();
  dataBase.db.execute(
    "UPDATE ASSIATANCEAPPDATA SET ChatAI_FontSize = $aiFontSize, ChatAI_FontBold = $aiFontBold,ChatAI_bgColor = $aiBgColor,ChatUser_FontSize = $userFontSize,ChatUser_FontBold = $userFontBold,ChatUser_bgColor = $userBgColor,ChatUser_textColor = $userTextColor WHERE Email_or_Phone = '$email'",
  );
}

Future nameChange(name, email) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute(
      "UPDATE ASSIATANCEAPPDATA SET UserName = '$name' WHERE Email_or_Phone = '$email'",
    );
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}

Future emailChange(oldEmail, newEmail) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute(
      "UPDATE ASSIATANCEAPPDATA SET Email_or_Phone = '$oldEmail' WHERE Email_or_Phone = '$newEmail'",
    );
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}

Future passwordChange(password, email) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute(
      "UPDATE ASSIATANCEAPPDATA SET Password = '$password' WHERE Email_or_Phone = '$email'",
    );
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}
Future imageChange(photo, email) async {
  final dataBase = InitializeDatabase();
  try {
    dataBase.db.execute(
      "UPDATE ASSIATANCEAPPDATA SET Photo = '$photo' WHERE Email_or_Phone = '$email'",
    );
    return true;
  } catch (err) {
    log(err.toString());
    return false;
  }
}