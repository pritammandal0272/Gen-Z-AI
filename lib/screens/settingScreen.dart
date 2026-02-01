import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/dataBase/updateValues.dart';
import 'package:voice_assistant/controller/functions/googleLogin.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/historyScreen/view/historyScreen.dart';
import 'package:voice_assistant/screens/scannerScreen/view/AiScanner.dart';
import 'package:voice_assistant/screens/aboutApp.dart';
import 'package:voice_assistant/screens/chatSettings.dart';
import 'package:voice_assistant/screens/feedBackScreen.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/screens/smartAssistance.dart';
import 'package:voice_assistant/screens/submitedFeedback.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final getxObj = Get.find<getController>();
  final TextEditingController changeUserNameController =
      TextEditingController();
  final TextEditingController changeUserEmailController =
      TextEditingController();
  final TextEditingController changeuserPasswordController =
      TextEditingController();
  final TextEditingController changeConfirmuserPasswordController =
      TextEditingController();
  final FocusNode focusUserName = FocusNode();
  final FocusNode focusUserEmail = FocusNode();
  final FocusNode focususerPassword = FocusNode();
  final FocusNode focusConfirmuserPassword = FocusNode();
  final GlobalKey<FormState> fromkeyUserName = GlobalKey<FormState>();
  final GlobalKey<FormState> fromkeyUserEmail = GlobalKey<FormState>();
  final GlobalKey<FormState> fromkeyuserPassword = GlobalKey<FormState>();
  @override
  void initState() {
    getxObj.passwordFlag.value = false;
    getxObj.confirmPasswordFlag.value = false;
    changeUserNameController.text = getxObj.logInUserData.isNotEmpty
        ? getxObj.logInUserData[0]["UserName"]
        : "";
    changeUserEmailController.text = getxObj.logInUserData.isNotEmpty
        ? getxObj.logInUserData[0]["Email_or_Phone"]
        : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: TextGradiate(
          text: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
          gradientType: GradientType.linear,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: getxObj.darkMode.value
                      ? const Color.fromARGB(111, 158, 158, 158)
                      : Color.fromRGBO(37, 100, 235, 0.474),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          spacing: 13,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorsScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(111, 158, 158, 158),
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    spacing: 15,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(300),
                            ),
                            child: Obx(() {
                              return Container(
                                height: 60,
                                width: 60,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: const Color.fromARGB(
                                    52,
                                    96,
                                    125,
                                    139,
                                  ),
                                  backgroundImage:
                                      getxObj.logInUserData.isNotEmpty &&
                                          getxObj.logInUserData[0]["Photo"] ==
                                              ""
                                      ? AssetImage("assets/userLogo.png")
                                      : getxObj.logInUserData.isNotEmpty
                                      ? FileImage(
                                          File(
                                            getxObj.logInUserData[0]["Photo"],
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            }),
                          ),

                          Obx(
                            () => Column(
                              spacing: 5,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getxObj.logInUserData.isNotEmpty
                                      ? getxObj.logInUserData[0]["UserName"]
                                      : "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    height: 1,
                                  ),
                                ),
                                getxObj.logInUserData[0]["Email_or_Phone"] == ""
                                    ? SizedBox()
                                    : Text(
                                        getxObj.logInUserData.isNotEmpty
                                            ? getxObj
                                                  .logInUserData[0]["Email_or_Phone"]
                                            : "",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          height: 1,
                                        ),
                                      ),
                                SizedBox(
                                  height: 20,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 2,
                                      ),
                                      minimumSize: Size.zero,

                                      backgroundColor: const Color.fromARGB(
                                        40,
                                        33,
                                        149,
                                        243,
                                      ),
                                      side: BorderSide(
                                        color: Colors.blue,
                                        width: 0.5,
                                      ),
                                    ),
                                    onPressed: () {},

                                    child: Row(
                                      spacing: 2,
                                      children: [
                                        Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.blueAccent,
                                          size: 16,
                                        ),
                                        Text(
                                          getxObj.logInUserData[0]["Email_or_Phone"] ==
                                                  ""
                                              ? "Guest User"
                                              : "Normal User",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      getxObj.logInUserData[0]["Email_or_Phone"] == ""
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 10,
                                      ),
                                      minimumSize: Size.zero,
                                      elevation: 0,
                                      alignment: Alignment.center,
                                      backgroundColor: const Color.fromARGB(
                                        57,
                                        33,
                                        149,
                                        243,
                                      ),
                                      side: BorderSide(
                                        color: Colors.blue,
                                        width: 0.5,
                                      ),
                                    ),
                                    onPressed: () {
                                      showLoginBottomSheet(context);
                                    },

                                    child: Row(
                                      spacing: 5,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.login,
                                          color: Colors.blue,
                                          size: 22,
                                        ),
                                        Text(
                                          "Sign In",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 10,
                                      ),
                                      minimumSize: Size.zero,
                                      elevation: 0,
                                      alignment: Alignment.center,
                                      backgroundColor: const Color.fromARGB(
                                        57,
                                        33,
                                        149,
                                        243,
                                      ),
                                      side: BorderSide(
                                        color: Colors.blue,
                                        width: 0.5,
                                      ),
                                    ),
                                    onPressed: () {
                                      showSignUpBottomSheet(context);
                                    },

                                    child: Row(
                                      spacing: 5,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.app_registration,
                                          color: Colors.blue,
                                          size: 22,
                                        ),
                                        Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 10,
                                ),
                                minimumSize: Size.zero,
                                elevation: 0,
                                alignment: Alignment.center,
                                backgroundColor: const Color.fromARGB(
                                  44,
                                  244,
                                  67,
                                  54,
                                ),
                                side: BorderSide(color: Colors.red, width: 0.5),
                              ),
                              onPressed: () async {
                                final sp =
                                    await SharedPreferences.getInstance();
                                await sp.remove("isEmail");
                                if (sp.getBool("googleLogin") ?? false) {
                                  sp.setBool("googleLogin", false);
                                  GoogleLoginService().logout();
                                }
                                Get.offAll(
                                  () => LoginScreen(),
                                  transition: Transition.zoom,
                                );
                                showSnackbarFunction(
                                  context,
                                  "Logout Successfully",
                                  Colors.blue,
                                  Icons.check_circle_outline,
                                );
                              },

                              child: Row(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),

                Positioned(
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(300),
                          color: const Color(0xFF5B8CFF).withOpacity(0.20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 7,
                      children: [
                        getxObj.logInUserData[0]["Email_or_Phone"] == ""
                            ? SizedBox()
                            : Text(
                                "EDIT PROFILE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                        getxObj.logInUserData[0]["Email_or_Phone"] == ""
                            ? SizedBox()
                            : Container(
                                margin: EdgeInsets.only(bottom: 17),
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      111,
                                      158,
                                      158,
                                      158,
                                    ),
                                    width: 0.5,
                                  ),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      DummyData.settingsProfileOptions.length,
                                  itemBuilder: (context, innerIndex) {
                                    return ExpansionTile(
                                      tilePadding: EdgeInsets.all(13),
                                      minTileHeight: 10,

                                      onExpansionChanged: (value) {},
                                      shape: Border(
                                        bottom: BorderSide(
                                          color: innerIndex == 3
                                              ? Colors.transparent
                                              : const Color.fromARGB(
                                                  68,
                                                  158,
                                                  158,
                                                  158,
                                                ),
                                          width: 0.5,
                                        ),
                                      ),
                                      collapsedShape: Border(
                                        bottom: BorderSide(
                                          color: innerIndex == 3
                                              ? Colors.transparent
                                              : const Color.fromARGB(
                                                  68,
                                                  158,
                                                  158,
                                                  158,
                                                ),
                                          width: 0.5,
                                        ),
                                      ),

                                      title: Row(
                                        spacing: 8,
                                        children: [
                                          Icon(
                                            DummyData
                                                .settingsProfileOptions[innerIndex]["icon"],
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            DummyData
                                                .settingsProfileOptions[innerIndex]["title"],
                                          ),
                                        ],
                                      ),
                                      children: [
                                        innerIndex == 0
                                            ? _nameChage()
                                            : innerIndex == 1
                                            ? _emailChange()
                                            : innerIndex == 2
                                            ? _passwordChange()
                                            : _photoChange(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: DummyData.settingsItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 7,
                          children: [
                            Text(
                              index == 0
                                  ? "CHAT & ASSISTANCE"
                                  : index == 1
                                  ? "HISTORYS"
                                  : " APP INFO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    index == DummyData.settingsItems.length - 1
                                    ? 100
                                    : 17,
                              ),
                              decoration: BoxDecoration(
                                color: colorsScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    111,
                                    158,
                                    158,
                                    158,
                                  ),
                                  width: 0.5,
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    DummyData.settingsItems[index].length,
                                itemBuilder: (context, innerIndex) {
                                  return InkWell(
                                    onTap: () {
                                      _routeOptionClick(index, innerIndex);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 22,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                innerIndex ==
                                                    DummyData
                                                            .settingsItems[index]
                                                            .length -
                                                        1
                                                ? Colors.transparent
                                                : const Color.fromARGB(
                                                    68,
                                                    158,
                                                    158,
                                                    158,
                                                  ),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 8,
                                            children: [
                                              Icon(
                                                DummyData
                                                    .settingsItems[index][innerIndex]["icon"],
                                                color: Colors.blueGrey,
                                              ),
                                              Text(
                                                DummyData
                                                    .settingsItems[index][innerIndex]["title"],
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          index == 0 && innerIndex == 2
                                              ? Obx(
                                                  () => Switch(
                                                    value:
                                                        getxObj.darkMode.value,
                                                    padding: EdgeInsets.all(0),
                                                    thumbColor:
                                                        WidgetStatePropertyAll(
                                                          Colors.white,
                                                        ),
                                                    activeColor:
                                                        const Color.fromARGB(
                                                          255,
                                                          0,
                                                          94,
                                                          255,
                                                        ),
                                                    thumbIcon:
                                                        WidgetStatePropertyAll(
                                                          Icon(
                                                            getxObj
                                                                    .darkMode
                                                                    .value
                                                                ? Icons
                                                                      .check_circle
                                                                : Icons.cancel,
                                                            color:
                                                                getxObj
                                                                    .darkMode
                                                                    .value
                                                                ? Colors
                                                                      .blueAccent
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                    onChanged: (value) async {
                                                      final sp =
                                                          await SharedPreferences.getInstance();
                                                      sp.setBool(
                                                        "darkMode",
                                                        value,
                                                      );
                                                      getxObj.darkMode.value =
                                                          value;
                                                    },
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: const Color.fromARGB(
                                                    101,
                                                    158,
                                                    158,
                                                    158,
                                                  ),
                                                  size: 14,
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameChage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: fromkeyUserName,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Fill the TextBox !!";
                } else {
                  return null;
                }
              },
              controller: changeUserNameController,
              focusNode: focusUserName,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.blue,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(40, 33, 149, 243),
                contentPadding: EdgeInsets.all(5),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                ),
                hintText: "Enter Name....",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                  borderSide: BorderSide(color: Colors.blue, width: 0.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              try {
                if (fromkeyUserName.currentState!.validate()) {
                  if (changeUserNameController.text ==
                      getxObj.logInUserData[0]["UserName"]) {
                    showSnackbarFunction(
                      context,
                      "Please change name",
                      Colors.deepOrange,
                      Icons.info,
                    );
                  } else {
                    await nameChange(
                      changeUserNameController.text,
                      getxObj.logInUserData[0]["Email_or_Phone"],
                    );
                    Map<String, dynamic> mutableUser = {
                      ...getxObj.logInUserData[0],
                      "UserName": changeUserNameController.text,
                    };
                    getxObj.logInUserData[0] = mutableUser;

                    showSnackbarFunction(
                      context,
                      "Name Changes Successfully",
                      Colors.blue,
                      Icons.check_circle,
                    );
                    focusUserName.unfocus();
                  }
                }
              } catch (err) {
                showSnackbarFunction(
                  context,
                  "Name Not Updated",
                  Colors.deepOrange,
                  Icons.info,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(81, 30, 64, 255),

              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(color: Color(0xFF1E40FF), width: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text(
                  "Change Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailChange() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: fromkeyUserEmail,
            child: TextFormField(
              validator: _validatorCheck,

              controller: changeUserEmailController,
              focusNode: focusUserEmail,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.blue,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(40, 33, 149, 243),
                contentPadding: EdgeInsets.all(5),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                ),
                hintText: "Enter Email....",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

                  borderSide: BorderSide(color: Colors.blue, width: 0.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              try {
                if (fromkeyUserEmail.currentState!.validate()) {
                  if (changeUserEmailController.text ==
                      getxObj.logInUserData[0]["Email_or_Phone"]) {
                    showSnackbarFunction(
                      context,
                      "Please change email",
                      Colors.deepOrange,
                      Icons.info,
                    );
                  } else {
                    await emailChange(
                      changeUserEmailController.text,
                      getxObj.logInUserData[0]["Email_or_Phone"],
                    );
                    Map<String, dynamic> mutableUser = {
                      ...getxObj.logInUserData[0],
                      "Email_or_Phone": changeUserEmailController.text,
                    };
                    getxObj.logInUserData[0] = mutableUser;
                    showSnackbarFunction(
                      context,
                      "Email Changes Successfully",
                      Colors.blue,
                      Icons.check_circle,
                    );
                    focusUserEmail.unfocus();
                  }
                }
              } catch (err) {
                showSnackbarFunction(
                  context,
                  "Email Not Updated",
                  Colors.deepOrange,
                  Icons.info,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(81, 30, 64, 255),

              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(color: Color(0xFF1E40FF), width: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text(
                  "Change Email",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordChange() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            key: fromkeyuserPassword,
            child: Column(
              spacing: 10,
              children: [
                Obx(
                  () => TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Fill the TextBox !!";
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    controller: changeuserPasswordController,
                    focusNode: focususerPassword,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    obscureText: getxObj.passwordFlag.value,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () => getxObj.passwordFlag.value =
                            !getxObj.passwordFlag.value,
                        icon: Icon(
                          getxObj.passwordFlag.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: !getxObj.passwordFlag.value
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      fillColor: const Color.fromARGB(40, 33, 149, 243),
                      contentPadding: EdgeInsets.all(5),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.red),
                      ),
                      hintText: "Old Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                        borderSide: BorderSide(color: Colors.blue, width: 0.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Fill the TextBox !!";
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    controller: changeConfirmuserPasswordController,
                    focusNode: focusConfirmuserPassword,
                    obscureText: getxObj.confirmPasswordFlag.value,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () => getxObj.confirmPasswordFlag.value =
                            !getxObj.confirmPasswordFlag.value,
                        icon: Icon(
                          getxObj.confirmPasswordFlag.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: !getxObj.confirmPasswordFlag.value
                              ? Colors.blueGrey
                              : Colors.blue,
                        ),
                      ),
                      fillColor: const Color.fromARGB(40, 33, 149, 243),
                      contentPadding: EdgeInsets.all(5),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.red),
                      ),
                      hintText: "New Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                        borderSide: BorderSide(color: Colors.blue, width: 0.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 0.5, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              try {
                if (fromkeyuserPassword.currentState!.validate() &&
                    changeuserPasswordController.text ==
                        getxObj.logInUserData[0]["Password"]) {
                  await passwordChange(
                    changeConfirmuserPasswordController.text,
                    getxObj.logInUserData[0]["Email_or_Phone"],
                  );
                  showSnackbarFunction(
                    context,
                    "Password Changes Successfully",
                    Colors.blue,
                    Icons.check_circle,
                  );
                  focususerPassword.unfocus();
                  focusConfirmuserPassword.unfocus();
                  changeuserPasswordController.clear();
                  changeConfirmuserPasswordController.clear();
                  fromkeyuserPassword.currentState!.reset();
                } else {
                  showSnackbarFunction(
                    context,
                    "Old Password Not Matched",
                    Colors.deepOrange,
                    Icons.info,
                  );
                }
              } catch (err) {
                showSnackbarFunction(
                  context,
                  "Password Not Updated",
                  Colors.deepOrange,
                  Icons.info,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(81, 30, 64, 255),

              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(color: Color(0xFF1E40FF), width: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoChange() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(300),
                ),
                child: Obx(
                  () =>
                      imagePickerController.imagePickimageProfileGetx.value ==
                          null
                      ? Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                              52,
                              96,
                              125,
                              139,
                            ),
                            radius: 50,
                            backgroundImage:
                                getxObj.logInUserData.isNotEmpty &&
                                    getxObj.logInUserData[0]["Photo"] == ""
                                ? AssetImage("assets/userLogo.png")
                                : getxObj.logInUserData.isNotEmpty
                                ? FileImage(
                                    File(getxObj.logInUserData[0]["Photo"]),
                                  )
                                : null,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              imagePickerController
                                  .imagePickimageProfileGetx
                                  .value!
                                  .path,
                            ),
                          ),
                          radius: 50,
                        ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    if (flag) {
                      Timer(Duration(seconds: 3), () {
                        flag = false;
                      });
                    } else {
                      flag = true;
                      imagePickerController.imagePickimageProfileGetx.value =
                          await imagePickerController.imagePickGallery();
                      // log(
                      //   imagePickerController.imagePickimageProfileGetx.value
                      //       .toString(),
                      // );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      color: Colors.grey,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                imagePickerController.imagePickimageProfileGetx.value != null
                    ? imagePickerController.saveProfileImage.value = true
                    : imagePickerController.saveProfileImage.value = false;
                if (imagePickerController.saveProfileImage.value) {
                  await imageChange(
                    imagePickerController.imagePickimageProfileGetx.value!.path,
                    getxObj.logInUserData[0]["Email_or_Phone"],
                  );
                  Map<String, dynamic> mutableUser = {
                    ...getxObj.logInUserData[0],
                    "Photo": imagePickerController
                        .imagePickimageProfileGetx
                        .value!
                        .path,
                  };
                  getxObj.logInUserData[0] = mutableUser;
                  imagePickerController.saveProfileImage.value = false;
                  showSnackbarFunction(
                    context,
                    "Image Uploaded Successfully",
                    Colors.blue,
                    Icons.check_circle_outline,
                  );
                }
              } catch (err) {
                showSnackbarFunction(
                  context,
                  "Image Not Updated",
                  Colors.deepOrange,
                  Icons.info,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(81, 30, 64, 255),

              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(color: Color(0xFF1E40FF), width: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.save, size: 18),
                SizedBox(width: 8),
                Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _routeOptionClick(index, innerIndex) async {
  if (index == 0) {
    if (innerIndex == 0) {
      Get.to(
        () => ChatSettings(data: {"backbuttonPress": true}),
        transition: Transition.rightToLeft,
      );
    }
    if (innerIndex == 1) {
      Get.to(
        () => SmartAssistance(data: {"backbuttonPress": true}),
        transition: Transition.rightToLeft,
      );
    }
  } else if (index == 1) {
    if (innerIndex == 0) {
      Get.to(
        () => HistoryScreen(historyType: "Chat History"),
        transition: Transition.rightToLeft,
      );
    } else if (innerIndex == 1) {
      Get.to(
        () => HistoryScreen(historyType: "Voice History"),
        transition: Transition.rightToLeft,
      );
    } else {
      Get.to(
        () => HistoryScreen(historyType: "Scanner History"),
        transition: Transition.rightToLeft,
      );
    }
  } else if (index == 2) {
    if (innerIndex == 0) {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final bool result = await sp.getBool("feedBackSubmited") ?? false;
      if (result) {
        Get.to(() => SubmitedFeedback(), transition: Transition.leftToRight);
      } else {
        Get.to(() => FeedBackScreen(), transition: Transition.rightToLeft);
      }
    } else if (innerIndex == 1) {
      Get.to(() => AboutAppScreen(), transition: Transition.rightToLeft);
    }
  }
}

String? _validatorCheck(value) {
  final emailCheck = !RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ).hasMatch(value.trim());
  final phCheck = !RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim());
  if (emailCheck && phCheck) {
    return "Enter valid email or mobile number !!";
  } else {
    return null;
  }
}
