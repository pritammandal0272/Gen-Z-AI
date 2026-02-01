import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/functions/settingsFunctions.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/toolsScreen.dart';
import 'package:voice_assistant/screens/homeScreen.dart';
import 'package:voice_assistant/screens/settingScreen.dart';
import 'package:voice_assistant/screens/smartAssistance.dart';
import 'package:voice_assistant/screens/voiceScreen.dart';

class MainScreen extends StatefulWidget {
  final data;
  const MainScreen({super.key, required this.data});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final isHome = Get.find<getController>();
  final getxObj = Get.put(getController());
  int currentPage = 0;

  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    // log("Email: ${widget.data}");
    call();
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.index != currentPage) {
        setState(() => currentPage = tabController.index);
      }
    });
  }

  Future call() async {
    if (widget.data["email"] == "") {
      final guestData = [
        {"UserName": "Guest Account", "Photo": "", "Email_or_Phone": ""},
      ];
      getxObj.logInUserData.assignAll(guestData);
    } else {
      var data = await logInuserData(widget.data["email"]);
      // log(data.toString());
      getxObj.logInUserData.assignAll(data);
      // read_all_DB_values();
      Initialize_Assistence_SettingsGetxVariable(getxObj.logInUserData);
      Initialize_Chat_SettingsGetxVariable(getxObj.logInUserData);
    }

    // log(getxObj.logInUserData.toString());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BottomBar(
        clip: Clip.none,
        offset: 0,
        start: 0,
        end: 0,
        hideOnScroll: true,
        respectSafeArea: false,
        barColor: colorsScheme.tertiary,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,

        width: MediaQuery.of(context).size.width,
        body: (context, scrollController) {
          final List<Widget> bottomBarPages = [
            HomeScreen(),
            SmartAssistance(data: {"backbuttonPress": false}),
            ToolsScreen(data: {"backbuttonPress": false}),
            SettingScreen(),
          ];
          return TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const NeverScrollableScrollPhysics(),
            children: bottomBarPages,
          );
        },

        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,

          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isHome.darkMode.value
                        ? const Color.fromARGB(111, 158, 158, 158)
                        : Color.fromRGBO(37, 100, 235, 0.474),
                    width: 0.5,
                  ),
                ),
              ),

              child: TabBar(
                labelColor: Colors.blue,
                dividerHeight: 0,
                controller: tabController,
                unselectedLabelColor: colorsScheme.secondary,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 0),
                  insets: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                labelPadding: EdgeInsets.zero,

                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Container(
                    margin: EdgeInsets.only(right: 36),
                    child: Tab(
                      icon: Icon(Icons.record_voice_over_rounded),
                      text: "Assistant",
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 36),
                    child: Tab(
                      icon: Icon(Icons.auto_fix_high_rounded),
                      text: "Tools",
                    ),
                  ),
                  Tab(icon: Icon(Icons.settings), text: "Settings"),
                ],
              ),
            ),
            Positioned(
              top: -25,
              child: Obx(
                () => Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: DummyData
                        .backgroundColorsAi[getxObj
                            .backgroundColorsAssistanceGetx
                            .value]
                        .withOpacity(0.6),
                    borderRadius: BorderRadius.circular(300),
                  ),
                  child: AvatarGlow(
                    glowColor:
                        DummyData.backgroundColorsAi[getxObj
                            .backgroundColorsAssistanceGetx
                            .value],
                    glowRadiusFactor: 0.4,
                    duration: Duration(seconds: 2),
                    child: FloatingActionButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(300),
                        side: BorderSide(
                          color: Colors.grey.withAlpha(80),
                          width: 1,
                        ),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              DummyData.backgroundColorsAi[getxObj
                                  .backgroundColorsAssistanceGetx
                                  .value],

                          border: Border.all(
                            color:
                                DummyData.backgroundColorsAi[getxObj
                                    .backgroundColorsAssistanceGetx
                                    .value],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: DummyData
                                  .backgroundColorsAi[getxObj
                                      .backgroundColorsAssistanceGetx
                                      .value]
                                  .withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        child: ElevatedButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.scale,
                              padding: EdgeInsets.zero,
                              showCloseIcon: true,
                              dialogBackgroundColor: Colors.black,
                              width: MediaQuery.of(context).size.width,
                              closeIcon: Icon(
                                Icons.close_sharp,
                                size: 17,
                                color: Colors.red,
                              ),
                              bodyHeaderDistance: 0,
                              body: VoiceScreen(),
                            ).show();
                          },
                          style: ElevatedButton.styleFrom(
                            iconColor: Colors.white,
                            backgroundColor: DummyData
                                .backgroundColorsAi[getxObj
                                    .backgroundColorsAssistanceGetx
                                    .value]
                                .withOpacity(0.5),
                            minimumSize: Size.zero,
                            padding: EdgeInsets.all(15),
                          ),
                          child: Icon(Icons.mic, size: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
