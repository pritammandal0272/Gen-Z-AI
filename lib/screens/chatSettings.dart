import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/functions/settingsFunctions.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

class ChatSettings extends StatefulWidget {
  final Map data;
  const ChatSettings({super.key, required this.data});

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  final getxObj = Get.put(getController());
  @override
  void dispose() {
   Initialize_Chat_SettingsGetxVariable(getxObj.logInUserData);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 250,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.data["backbuttonPress"]
                    ? InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back),
                      )
                    : SizedBox(),
                Expanded(
                  child: TextGradiate(
                    text: Center(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
                    gradientType: GradientType.linear,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                widget.data["backbuttonPress"]
                    ? SizedBox(height: 2)
                    : SizedBox(),
                Text(
                  "PREVIEW",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1,
                    fontSize: 15,
                  ),
                ),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 15,
                        top: 23,
                        bottom: 23,
                      ),
                      decoration: BoxDecoration(
                        color: getxObj.darkMode.value
                            ? Color(0xFF0F172A)
                            : const Color.fromARGB(62, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: Offset(0, -13),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "assets/logo.png",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Obx(
                                    () => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            getxObj.darkMode.value &&
                                                getxObj
                                                        .backgroundColorsAiGetx
                                                        .value ==
                                                    0
                                            ? Colors.black
                                            : DummyData
                                                  .backgroundColorsAi[getxObj
                                                  .backgroundColorsAiGetx
                                                  .value],
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        border: BoxBorder.all(
                                          color:
                                              DummyData
                                                      .backgroundColorsAi[getxObj
                                                      .backgroundColorsAiGetx
                                                      .value] ==
                                                  Colors.white
                                              ? Colors.grey.withAlpha(70)
                                              : Colors.white.withAlpha(70),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                              54,
                                              96,
                                              125,
                                              139,
                                            ),
                                            offset: Offset(0, 0),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "Hello! This is how your chat interface looks with current settings.",
                                        style: TextStyle(
                                          fontSize:
                                              getxObj.textSizeAiGetx.value,
                                          fontWeight:
                                              getxObj.chatBoldAiText.value
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Obx(
                                    () => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors:
                                              DummyData
                                                  .gradientColorsUser[getxObj
                                                  .backgroundColorsUserGetx
                                                  .value],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                        ),
                                        border: BoxBorder.all(
                                          color: const Color.fromARGB(
                                            170,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                              54,
                                              96,
                                              125,
                                              139,
                                            ),
                                            offset: Offset(0, 0),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "Looks great, thank you.",
                                        style: TextStyle(
                                          color:
                                              DummyData.textColorsAi[getxObj
                                                  .textColorsUserGetx
                                                  .value],
                                          fontSize:
                                              getxObj.textSizeUserGetx.value,
                                          fontWeight:
                                              getxObj.chatBoldUserText.value
                                              ? FontWeight.bold
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(2, 15),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "assets/logo.png",
                                  ),
                                ),
                              ),
                            ],
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
              ],
            ),
          ],
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: widget.data["backbuttonPress"]
                      ? const EdgeInsets.only(bottom: 0.0)
                      : EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 13),
                            child: Text(
                              "Ai DISPLAY & TEXT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 12,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: colorsScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              spacing: 10,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 15,
                                  ),
                                  child: Column(
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Font Size (1 - 30)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              getxObj.textSizeAiGetx.value
                                                  .toInt()
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            Icons.format_size,
                                            color: Colors.blueGrey,
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Slider(
                                                padding: EdgeInsets.all(0),
                                                value: getxObj
                                                    .textSizeAiGetx
                                                    .value,
                                                min: 7,
                                                max: 30,
                                                activeColor: Colors.blue,
                                                inactiveColor:
                                                    getxObj.darkMode.value
                                                    ? Colors.white
                                                    : Colors.blueGrey,
                                                thumbColor: Colors.white,
                                                onChanged: (value) {
                                                  getxObj.textSizeAiGetx.value =
                                                      value;
                                                },
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.format_size,
                                            color: getxObj.darkMode.value
                                                ? Colors.white
                                                : Colors.deepOrangeAccent,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: const Color.fromARGB(
                                    128,
                                    96,
                                    125,
                                    139,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bold Ai Text",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Switch(
                                              value:
                                                  getxObj.chatBoldAiText.value,
                                              padding: EdgeInsets.all(0),
                                              thumbColor:
                                                  WidgetStatePropertyAll(
                                                    getxObj.chatBoldAiText.value
                                                        ? Colors.white
                                                        : Colors.blueGrey,
                                                  ),
                                              activeColor: const Color.fromARGB(
                                                255,
                                                0,
                                                94,
                                                255,
                                              ),
                                              thumbIcon: WidgetStatePropertyAll(
                                                Icon(
                                                  getxObj.chatBoldAiText.value
                                                      ? Icons.check_circle
                                                      : Icons.cancel,
                                                  color:
                                                      getxObj
                                                          .chatBoldAiText
                                                          .value
                                                      ? Colors.blueAccent
                                                      : Colors.red,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                getxObj.chatBoldAiText.value =
                                                    value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: const Color.fromARGB(
                                    128,
                                    96,
                                    125,
                                    139,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "Response Backgrouns Color",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: DummyData
                                              .backgroundColorsAi
                                              .length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                getxObj
                                                        .backgroundColorsAiGetx
                                                        .value =
                                                    index;
                                              },
                                              child: Obx(
                                                () => Container(
                                                  padding: EdgeInsets.all(2),
                                                  margin: EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          getxObj
                                                                  .backgroundColorsAiGetx
                                                                  .value ==
                                                              index
                                                          ? Colors.blue
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            300,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            const Color.fromARGB(
                                                              111,
                                                              96,
                                                              125,
                                                              139,
                                                            ),
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          getxObj
                                                                  .darkMode
                                                                  .value &&
                                                              index == 0
                                                          ? Colors.black
                                                          : DummyData
                                                                .backgroundColorsAi[index],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.zero,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  116,
                                                  33,
                                                  243,
                                                  159,
                                                ),

                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 7,
                                            ),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            getxObj
                                                    .backgroundColorsAiGetx
                                                    .value =
                                                0;
                                            getxObj.textColorsAiGetx.value = 1;
                                            getxObj.textSizeAiGetx.value = 15;
                                            getxObj.chatBoldAiText.value =
                                                false;
                                          },
                                          child: Text(
                                            "Click Set Default Settings",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 13),
                            child: Text(
                              "User DISPLAY & TEXT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 12,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: colorsScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              spacing: 10,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 15,
                                  ),
                                  child: Column(
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Font Size (1 - 30)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              getxObj.textSizeUserGetx.value
                                                  .toInt()
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            Icons.format_size,
                                            color: Colors.blueGrey,
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Obx(
                                              () => Slider(
                                                padding: EdgeInsets.all(0),
                                                value: getxObj
                                                    .textSizeUserGetx
                                                    .value,
                                                min: 7,
                                                max: 30,
                                                inactiveColor: Colors.blueGrey,
                                                activeColor: Colors.blue,
                                                thumbColor: Colors.white,
                                                onChanged: (value) {
                                                  getxObj
                                                          .textSizeUserGetx
                                                          .value =
                                                      value;
                                                },
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.format_size,
                                            color: Colors.redAccent,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: const Color.fromARGB(
                                    128,
                                    96,
                                    125,
                                    139,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bold User Text",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Switch(
                                              value: getxObj
                                                  .chatBoldUserText
                                                  .value,
                                              padding: EdgeInsets.all(0),
                                              thumbColor:
                                                  WidgetStatePropertyAll(
                                                    getxObj
                                                            .chatBoldUserText
                                                            .value
                                                        ? Colors.white
                                                        : Colors.blueGrey,
                                                  ),
                                              activeColor: const Color.fromARGB(
                                                255,
                                                0,
                                                94,
                                                255,
                                              ),
                                              thumbIcon: WidgetStatePropertyAll(
                                                Icon(
                                                  getxObj.chatBoldUserText.value
                                                      ? Icons.check_circle
                                                      : Icons.cancel,
                                                  color:
                                                      getxObj
                                                          .chatBoldUserText
                                                          .value
                                                      ? Colors.blueAccent
                                                      : Colors.red,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                getxObj.chatBoldUserText.value =
                                                    value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: const Color.fromARGB(
                                    128,
                                    96,
                                    125,
                                    139,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Theme",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Obx(
                                        () => Container(
                                          height: 45,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                              66,
                                              70,
                                              78,
                                              0.299,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Row(
                                            spacing: 10,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    minimumSize: Size.zero,
                                                    backgroundColor:
                                                        getxObj
                                                            .chatUserTheme
                                                            .value
                                                        ? const Color.fromARGB(
                                                            101,
                                                            33,
                                                            149,
                                                            243,
                                                          )
                                                        : Colors.transparent,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 7,
                                                        ),
                                                    elevation:
                                                        getxObj
                                                            .chatUserTheme
                                                            .value
                                                        ? 2
                                                        : 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    getxObj
                                                            .chatUserTheme
                                                            .value =
                                                        true;
                                                    // log(
                                                    //   getxObj
                                                    //       .chatUserTheme
                                                    //       .value
                                                    //       .toString(),
                                                    // );
                                                  },
                                                  child: Text(
                                                    "Background Color",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    minimumSize: Size.zero,
                                                    backgroundColor:
                                                        !getxObj
                                                            .chatUserTheme
                                                            .value
                                                        ? const Color.fromARGB(
                                                            101,
                                                            33,
                                                            149,
                                                            243,
                                                          )
                                                        : Colors.transparent,
                                                    elevation:
                                                        !getxObj
                                                            .chatUserTheme
                                                            .value
                                                        ? 2
                                                        : 0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                          vertical: 7,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    getxObj
                                                            .chatUserTheme
                                                            .value =
                                                        false;
                                                  },
                                                  child: Text(
                                                    "Text Color",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Choose Color",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: DummyData
                                              .backgroundColorsAi
                                              .length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                getxObj.chatUserTheme.value
                                                    ? getxObj
                                                              .backgroundColorsUserGetx
                                                              .value =
                                                          index
                                                    : getxObj
                                                              .textColorsUserGetx
                                                              .value =
                                                          index;
                                              },
                                              child: Obx(
                                                () => Container(
                                                  padding: EdgeInsets.all(2),
                                                  margin: EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          getxObj
                                                                      .backgroundColorsUserGetx
                                                                      .value ==
                                                                  index &&
                                                              getxObj
                                                                  .chatUserTheme
                                                                  .value
                                                          ? Colors.blue
                                                          : getxObj
                                                                        .textColorsUserGetx
                                                                        .value ==
                                                                    index &&
                                                                !getxObj
                                                                    .chatUserTheme
                                                                    .value
                                                          ? Colors.blue
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    height: 40,
                                                    width: 42,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            const Color.fromARGB(
                                                              111,
                                                              96,
                                                              125,
                                                              139,
                                                            ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            300,
                                                          ),
                                                      gradient:
                                                          getxObj
                                                              .chatUserTheme
                                                              .value
                                                          ? LinearGradient(
                                                              colors: DummyData
                                                                  .gradientColorsUser[index],
                                                            )
                                                          : null,
                                                      color:
                                                          !getxObj
                                                              .chatUserTheme
                                                              .value
                                                          ? DummyData
                                                                .textColorsAi[index]
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.zero,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  116,
                                                  33,
                                                  243,
                                                  159,
                                                ),

                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 7,
                                            ),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            getxObj
                                                    .backgroundColorsUserGetx
                                                    .value =
                                                0;
                                            getxObj.textColorsUserGetx.value =
                                                0;
                                            getxObj.textSizeUserGetx.value = 15;
                                            getxObj.chatBoldUserText.value =
                                                false;
                                          },
                                          child: Text(
                                            "Click Set Default Settings",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  final bool result = await saveSettingsChat(
                    getxObj.textSizeAiGetx.value.toInt(),
                    getxObj.chatBoldAiText.value ? 1 : 0,
                    getxObj.backgroundColorsAiGetx.value,
                    getxObj.textSizeUserGetx.value.toInt(),
                    getxObj.chatBoldUserText.value ? 1 : 0,
                    getxObj.backgroundColorsUserGetx.value,

                    getxObj.textColorsUserGetx.value,
                  );
                  if (!result) {
                    showSnackbarFunction(
                      context,
                      "No changes were made.",
                      Colors.deepOrange,
                      Icons.info,
                    );
                  } else {
                    showSnackbarFunction(
                      context,
                      "Changes saved successfully.",
                      Colors.blue,
                      Icons.check_circle,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Color.fromRGBO(13, 89, 242, 1),
                  backgroundColor: Color.fromRGBO(13, 89, 242, 1),
                ),
                child: Text(
                  "Save Preferences",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
