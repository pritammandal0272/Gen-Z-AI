import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/chatScreen/view/chatScreen.dart';
import 'package:voice_assistant/screens/historyScreen/controller/fetchHistory.dart';
import 'package:voice_assistant/screens/historyScreen/controller/filterSearchHistory.dart';
import 'package:voice_assistant/screens/historyScreen/widget/confirmBox.dart';
import 'package:voice_assistant/screens/scannerScreen/view/AiScanner.dart';

class HistoryScreen extends StatefulWidget {
  final historyType;
  const HistoryScreen({super.key, required this.historyType});
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final getxObj = Get.find<getController>();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final TextEditingController searchBoxValue = TextEditingController();
  @override
  void initState() {
    historyFetch(getxObj.logInUserData[0]["UserId"], widget.historyType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 40,
        title: TextGradiate(
          text: Text(
            widget.historyType,
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
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => ConfirmBox(
                  title: "Are you sure?",
                  message:
                      "This action cannot be undone. All your chat history will be permanently deleted.",
                  historyType: widget.historyType,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
                Text(
                  "Clear all",
                  style: TextStyle(
                    height: 1,
                    fontSize: 13,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          spacing: 15,
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: fromKey,

              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Fill the TextBox !!";
                  } else {
                    return null;
                  }
                },
                controller: searchBoxValue,

                onChanged: filterSearch,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0.5, color: Colors.red),
                  ),
                  hintText: "Search conversations...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
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
              () => getxObj.historyData.isEmpty
                  ? _emptyHistory()
                  : Expanded(child: _buildHistoryList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    final getxObj = Get.find<getController>();
    final colorsScheme = Theme.of(context).colorScheme;

    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: getxObj.historyData.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = getxObj.historyData[index];
          var time = item?["date"].split(" ")[0];
          final showDivider =
              index == 0 ||
              time != getxObj.historyData[index - 1]["date"].split(" ")[0];
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDivider)
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(child: Divider(color: Colors.blueGrey)),
                      Text(
                        time,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.blueGrey)),
                    ],
                  ),

                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: colorsScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(111, 158, 158, 158),
                      width: 0.5,
                    ),
                  ),
                  child: widget.historyType == "Scanner History"
                      ? InkWell(
                          onTap: () {
                            Get.off(
                              () => AiScanner(data: item),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              spacing: 10,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          94,
                                          96,
                                          125,
                                          139,
                                        ),
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  height: 200,
                                  width: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: item["imageURL"] != null
                                        ? Image.file(
                                            File(item!["imageURL"]),
                                            fit: BoxFit.cover,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item!["aiScanerReply"].toString(),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple[50],
                            child: const Icon(
                              Icons.auto_awesome,
                              size: 18,
                              color: Colors.deepPurple,
                            ),
                          ),
                          title: Text(
                            widget.historyType == "Voice History"
                                ? item!["userVoice"].toString()
                                : item!["userSms"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.historyType == "Voice History"
                                ? item!["aiVoiceReply"].toString()
                                : item!["aiReply"].toString(),
                            maxLines: widget.historyType == "Voice History"
                                ? 2000
                                : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: widget.historyType == "Voice History"
                              ? null
                              : const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                          onTap: () {
                            if (widget.historyType != "Voice History") {
                              Get.to(
                                () => ChatScreen(
                                  dataFromAiSkills: {
                                    "type": "history",
                                    "data": item,
                                  },
                                ),
                                transition: Transition.rightToLeft,
                              );
                            }
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _emptyHistory() {
    final getxObj = Get.find<getController>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: getxObj.darkMode.value ? Colors.white : Colors.black,
          ),
          const SizedBox(height: 16),
          Text(
            "No results found",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }
}
