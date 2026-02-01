import 'package:voice_assistant/controller/dataBase/insertValueDB.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';

Future saveScnnerHistory(userId, imagePath, aiReply, date) async {
  if (aiReply != "Server Running Slow Please try again Later...") {
    await insertScannerHistory(
      userId as int,
      imagePath.toString(),
      aiReply.toString(),
      date.toString(),
    );
    read_all_DB_values();
  }
}
