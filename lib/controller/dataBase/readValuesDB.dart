
import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';

Future read_all_DB_values() async {
  final dataBase = InitializeDatabase();
//  final data =  
 dataBase.db.select('''SELECT * FROM chatHistory''');
  // log("Length: ${data}");
}

Future checkUserExists(email) async {
  final dataBase = InitializeDatabase();
  final data = dataBase.db.select(
    "SELECT * FROM ASSIATANCEAPPDATA WHERE Email_or_Phone = '$email'",
  );
  if (data.isNotEmpty) {
    return false;
  } else {
    return true;
  }
}

Future checkUserLogin(email, password) async {
  final dataBase = InitializeDatabase();
  final data = dataBase.db.select(
    "SELECT * FROM ASSIATANCEAPPDATA WHERE Email_or_Phone = '$email'",
  );
  if (data[0]["Password"] == password) {
    return true;
  } else {
    return false;
  }
}
Future logInuserData(email) async {
  final dataBase = InitializeDatabase();
  final data = dataBase.db.select("SELECT * FROM ASSIATANCEAPPDATA WHERE Email_or_Phone = '$email'");
  
  return data;
}


Future readChatHistory(userId) async{
  final dataBase = InitializeDatabase();
  try{
    final data = dataBase.db.select("SELECT * FROM chatHistory WHERE userId = $userId");
    return data;
  }catch(err){
    log(err.toString());
    return null;
  }
}
Future readScnnerHistory(userId) async{
  final dataBase = InitializeDatabase();
  try{
    final data = dataBase.db.select("SELECT * FROM scanerHistory WHERE userId = $userId");
    return data;
  }catch(err){
    log(err.toString());
    return null;
  }
}
Future readVoiceHistory(userId) async{
  final dataBase = InitializeDatabase();
  try{
    final data = dataBase.db.select("SELECT * FROM voiceHistory WHERE userId = $userId");
    return data;
  }catch(err){
    log(err.toString());
    return null;
  }
}