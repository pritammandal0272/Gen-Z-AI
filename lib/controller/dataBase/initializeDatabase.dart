import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class InitializeDatabase {
  static final InitializeDatabase d = InitializeDatabase._internal();
  factory InitializeDatabase() {
    return d;
  }
  InitializeDatabase._internal() {
    createDataBase();
  }
  late Database db;
  Future<void> createDataBase() async {
    final pathProvider = await getApplicationDocumentsDirectory();
    final dbPath = p.join(pathProvider.path, 'gen_Z_AI.db');
    db = sqlite3.open(dbPath);
    db.execute('''CREATE TABLE IF NOT EXISTS ASSIATANCEAPPDATA(
      UserId INTEGER PRIMARY KEY AUTOINCREMENT,
      UserName TEXT(100),
      Password TEXT(50),
      Email_or_Phone TEXT(50),
      Photo TEXT(2000),
      Output_Voice INTEGER DEFAULT 0,
      Output_Language TEXT(50) DEFAULT 'english',
      SelectMode TEXT(100) DEFAULT 'normal',
      Assist_FontSize INTEGER DEFAULT 15,
      Assist_FontBold INTEGER DEFAULT 0,
      Assist_bgColor INTEGER DEFAULT 3,
      Assist_textColor INTEGER DEFAULT 0,
      ChatAI_FontSize INTEGER DEFAULT 15,
      ChatAI_FontBold INTEGER DEFAULT 0,
      ChatAI_bgColor INTEGER DEFAULT 0,
      ChatAI_textColor INTEGER DEFAULT 1,
      ChatUser_FontSize INTEGER DEFAULT 15,
      ChatUser_FontBold INTEGER DEFAULT 0,
      ChatUser_bgColor INTEGER DEFAULT 0,
      ChatUser_textColor INTEGER DEFAULT 0)''');
    db.execute(
      "CREATE TABLE IF NOT EXISTS chatHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,userSms TEXT,aiReply TEXT,date TEXT)",
    );
    db.execute(
      "CREATE TABLE IF NOT EXISTS voiceHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,userVoice TEXT,aiVoiceReply TEXT,date TEXT)",
    );
    db.execute(
      "CREATE TABLE IF NOT EXISTS scanerHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,imageURL TEXT,aiScanerReply TEXT,date TEXT)",
    );
    // db.execute(
    //   "CREATE TABLE IF NOT EXISTS translateHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,sourceText TEXT,aiTranslateText TEXT,date TEXT)",
    // );
    // log(dbPath.toString());
  }
}
