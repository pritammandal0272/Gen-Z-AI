import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/chatScreen/view/chatScreen.dart';
import 'package:voice_assistant/screens/mainScreen.dart';

class ToolsScreen extends StatefulWidget {
  final Map data;
  const ToolsScreen({super.key, required this.data});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  final getxObj = Get.find<getController>();
  final List<TextEditingController> textBoxValue = [];
  final List<GlobalKey<FormState>> _fromKey = [];
  final List<FocusNode> _textFocus = [];
  @override
  void initState() {
    int listLength = DummyData.suggestiveQuestion["All"].length;
    for (int i = 0; i < listLength; i++) {
      textBoxValue.add(TextEditingController());
      _fromKey.add(GlobalKey<FormState>());
      _textFocus.add(FocusNode());
    }
    getxObj.suggestiveQuestionOptionLoader.value = true;
    Future.delayed(Duration(seconds: 2), () {
      getxObj.suggestiveQuestionOptionLoader.value = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    int listLength = DummyData.suggestiveQuestion["All"].length;
    for (int i = 0; i < listLength; i++) {
      _fromKey[i].currentState?.reset();
      _textFocus[i].unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categoryList = [
      "All",
      "Writing",
      "Study",
      "Productivity",
      "Story",
      "Codeing",
    ];
    final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 110,
        title: Column(
          spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextGradiate(
                  text: Text(
                    "AI Skills",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
                  gradientType: GradientType.linear,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                widget.data["backbuttonPress"]
                    ? InkWell(
                        onTap: () {
                          Get.offAll(
                            () => MainScreen(data: {"email":""},),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color.fromARGB(
                            93,
                            96,
                            125,
                            139,
                          ),
                          radius: 17,
                          child: Icon(
                            Icons.home,
                            color: const Color.fromARGB(145, 33, 149, 243),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: 2),
            Text(
              "What can I help with today?",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 33,
              child: ListView.builder(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          backgroundColor:
                              getxObj.selectAiSkillsCategory.value == index
                              ? Color.fromRGBO(13, 89, 242, 1)
                              : getxObj.darkMode.value
                              ? const Color.fromARGB(41, 158, 158, 158)
                              : Colors.transparent,
                          side: BorderSide(
                            color: Color.fromRGBO(13, 89, 242, 0.329),
                          ),
                          foregroundColor: getxObj.darkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          getxObj.selectAiSkillsCategory.value = index;
                          getxObj.suggestiveQuestionOptionLoader.value = true;
                          Future.delayed(Duration(seconds: 2), () {
                            getxObj.suggestiveQuestionOption.value =
                                categoryList[index];
                            getxObj.suggestiveQuestionOptionLoader.value =
                                false;
                          });
                        },
                        child: Text(
                          categoryList[index],
                          style: TextStyle(
                            color: getxObj.selectAiSkillsCategory.value == index
                                ? Colors.white
                                : getxObj.darkMode.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            height: 0.5,
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
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: widget.data["backbuttonPress"] ? 0 : 70,
        ),
        child: Obx(
          () => Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: getxObj.suggestiveQuestionOptionLoader.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: DummyData
                            .suggestiveQuestion[getxObj
                                .suggestiveQuestionOption
                                .value]
                            ?.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 12,
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: colorsScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: DummyData
                                        .suggestiveQuestion[getxObj
                                            .suggestiveQuestionOption
                                            .value]?[index]["color"]
                                        .withOpacity(0.5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: DummyData
                                          .suggestiveQuestion[getxObj
                                              .suggestiveQuestionOption
                                              .value]?[index]["color"]
                                          .withOpacity(0.4),
                                      offset: Offset(0, 0),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -14.9,
                                      right: -14.9,
                                      child: Container(
                                        height: 140,
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.25,
                                        child: ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                            sigmaX: 0,
                                            sigmaY: 0,
                                          ),
                                          child: Container(
                                            height: 140,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(80),
                                                topRight: Radius.circular(20),
                                              ),
                                              color: DummyData
                                                  .suggestiveQuestion[getxObj
                                                      .suggestiveQuestionOption
                                                      .value]?[index]["color"]
                                                  .withOpacity(0.10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Column(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(10),
                                                minimumSize: Size.zero,
                                                elevation: 0,
                                                backgroundColor: DummyData
                                                    .suggestiveQuestion[getxObj
                                                        .suggestiveQuestionOption
                                                        .value]?[index]["color"]
                                                    .withOpacity(0.20),
                                                iconColor:
                                                    DummyData
                                                        .suggestiveQuestion[getxObj
                                                        .suggestiveQuestionOption
                                                        .value]?[index]["color"],
                                                iconSize: 23,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        300,
                                                      ),
                                                  side: BorderSide(
                                                    color: DummyData
                                                        .suggestiveQuestion[getxObj
                                                            .suggestiveQuestionOption
                                                            .value]?[index]["color"]
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                              label: Icon(
                                                DummyData
                                                    .suggestiveQuestion[getxObj
                                                    .suggestiveQuestionOption
                                                    .value]?[index]["icon"],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_outward,
                                              color: const Color.fromARGB(
                                                166,
                                                158,
                                                158,
                                                158,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DummyData
                                                  .suggestiveQuestion[getxObj
                                                  .suggestiveQuestionOption
                                                  .value]?[index]["title"],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              DummyData
                                                  .suggestiveQuestion[getxObj
                                                  .suggestiveQuestionOption
                                                  .value]?[index]["subTitle"],
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  156,
                                                  158,
                                                  158,
                                                  158,
                                                ),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Form(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            key: _fromKey[index],
                                            child: TextFormField(
                                              controller: textBoxValue[index],
                                              minLines: 3,
                                              maxLines: 6,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.trim().isEmpty) {
                                                  return "Fill the TextBox !!";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              cursorColor: Colors.blue,

                                              textInputAction:
                                                  TextInputAction.newline,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              focusNode: _textFocus[index],
                                              decoration: InputDecoration(
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 0.5,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                hintText: "Type here...",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 0.5,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 0.5,
                                                        color:
                                                            const Color.fromARGB(
                                                              71,
                                                              158,
                                                              158,
                                                              158,
                                                            ),
                                                      ),
                                                    ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                filled: true,

                                                fillColor: DummyData
                                                    .suggestiveQuestion["All"]?[index]["color"]
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        SizedBox(
                                          height: 45,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: DummyData
                                                  .suggestiveQuestion[getxObj
                                                      .suggestiveQuestionOption
                                                      .value]?[index]["color"]
                                                  .withOpacity(0.2),
                                              side: BorderSide(
                                                color: DummyData
                                                    .suggestiveQuestion[getxObj
                                                        .suggestiveQuestionOption
                                                        .value]?[index]["color"]
                                                    .withOpacity(0.8),
                                                width: 0.5,
                                              ),
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.only(
                                                left: 10,
                                              ),
                                            ),
                                            onPressed: () {
                                              _submitButtonFunction(index);
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: 7,
                                              children: [
                                                Icon(
                                                  Icons.auto_awesome,
                                                  color:
                                                      DummyData
                                                          .suggestiveQuestion[getxObj
                                                          .suggestiveQuestionOption
                                                          .value]?[index]["color"],
                                                  size: 20,
                                                ),
                                                Text(
                                                  DummyData
                                                      .suggestiveQuestion[getxObj
                                                      .suggestiveQuestionOption
                                                      .value]?[index]["question"],
                                                  style: TextStyle(
                                                    color:
                                                        DummyData
                                                            .suggestiveQuestion[getxObj
                                                            .suggestiveQuestionOption
                                                            .value]?[index]["color"],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Positioned(
                              //   child: Container(
                              //     height: 60,
                              //     width:
                              //         MediaQuery.of(context).size.width * 0.55,
                              //     child: ImageFiltered(
                              //       imageFilter: ImageFilter.blur(
                              //         sigmaX: 80,
                              //         sigmaY: 80,
                              //       ),
                              //       child: Container(
                              //         height: 60,
                              //         width:
                              //             MediaQuery.of(context).size.width *
                              //             0.5,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(
                              //             300,
                              //           ),
                              //           color: const Color(
                              //             0xFF5B8CFF,
                              //           ).withOpacity(0.20),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitButtonFunction(index) {
    if (!_fromKey[index].currentState!.validate()) {
      return;
    }
    final DateTime time = DateTime.now();
    var now = DateFormat.jm().format(time);
    final dataFromUser = {
      "id": 0,
      "role": "user",
      "message":
          "${textBoxValue[index].text}\n\n${DummyData.suggestiveQuestion[getxObj.suggestiveQuestionOption.value]?[index]["question"]}",
      "time": now.toString(),
    };
    textBoxValue[index].clear();
    _fromKey[index].currentState?.reset();
    _textFocus[index].unfocus();
    Get.to(
      () => ChatScreen(dataFromAiSkills: {"type": "aiSkills", "data": dataFromUser}),
      transition: Transition.zoom,
    );
  }
}
