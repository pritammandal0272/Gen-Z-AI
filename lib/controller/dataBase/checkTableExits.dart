import 'dart:developer';

import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';

Future deleteTable() async {
  log("message");
  final dataBase = InitializeDatabase();
  
  dataBase.db.select(
    "SELECT name FROM sqlite_master WHERE type='table' AND name='ASSIATANCEAPPDATA'",
  );

  // log(d.toString());
}
