import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_assistant/controller/dataBase/initializeDatabase.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/controller/internetCheck/controller/internetCheckController.dart';
import 'package:voice_assistant/controller/utils/screenTheme.dart';
import 'package:voice_assistant/firebase_options.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/screens/sharePreference/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeDatabase().createDataBase();
  runApp(MainWidget());
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isHome = Get.put(getController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppColor.lightTheme,
        darkTheme: AppColor.darkTheme,

        themeMode: isHome.darkMode.value ? ThemeMode.dark : ThemeMode.light,

        home: SplashScreen(),
      ),
    );
  }
}
