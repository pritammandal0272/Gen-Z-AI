import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/dummyData.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/submitedFeedback.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final getxObj = Get.find<getController>();

  final FocusNode _textFocus = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextGradiate(
          text: Text(
            "FeedBack & Suggestions",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
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
          preferredSize: Size.fromHeight(3),
          child: Container(
            height: 0.5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(16, 19, 34, 1),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How can we Improve ?",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Your feedback helps us improve our Al experience for everyone.",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorsScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(52, 96, 125, 139),
                            offset: Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],
                        border: Border.all(
                          color: const Color.fromARGB(91, 96, 125, 139),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 50,
                        bottom: 30,
                      ),
                      margin: EdgeInsets.only(top: 20, left: 25, right: 25),

                      child: Column(
                        spacing: 20,

                        children: [
                          Text(
                            "RATE YOUR EXPERIENCE",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        getxObj.starFeedback.value = index;
                                        // log(
                                        //   getxObj.starFeedback.value.toString(),
                                        // );
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:
                                            index <= getxObj.starFeedback.value
                                            ? Colors.blueAccent
                                            : Colors.blueGrey,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Obx(
                            () => Text(
                              getxObj.starFeedback.value == (-1)
                                  ? "Give Rating"
                                  : "${DummyData.feedbackData[getxObj.starFeedback.value]["text"]} ${DummyData.feedbackData[getxObj.starFeedback.value]["emoji"]}",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 94, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    child: Obx(
                      () => Text(
                        getxObj.starFeedback.value == (-1)
                            ? "☹️"
                            : DummyData.feedbackData[getxObj
                                  .starFeedback
                                  .value]["emoji"],
                        style: TextStyle(fontSize: 70),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is the Regarding ?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 42,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: DummyData.features.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final data = DummyData.features[index];
                        return Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                if (getxObj.feedbackIndex.contains(index)) {
                                  getxObj.feedbackIndex.remove(index);
                                } else {
                                  getxObj.feedbackIndex.add(index);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: const Color.fromARGB(84, 96, 125, 139),
                                ),
                                backgroundColor:
                                    getxObj.feedbackIndex.contains(index)
                                    ? const Color.fromARGB(255, 37, 100, 235)
                                    : Colors.transparent, // blue
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ), // pill shape
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 5,
                                children: [
                                  Icon(
                                    data["icon"],
                                    color: getxObj.feedbackIndex.contains(index)
                                        ? Colors.white
                                        : Colors.blueGrey,
                                    size: 20,
                                  ),
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          getxObj.feedbackIndex.contains(index)
                                          ? Colors.white
                                          : Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detailed Feedback",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Fill the TextBox !!";
                        } else {
                          return null;
                        }
                      },
                      minLines: 6,
                      maxLines: 10,
                      controller: textController,
                      focusNode: _textFocus,
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
                        hintText:
                            "Tell us what you liked or what we can do better ...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 0.5,
                          ),
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
              ElevatedButton(
                onPressed: () {
                  _submitFeedBack();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: getxObj.darkMode.value
                      ? const Color.fromARGB(90, 37, 100, 235)
                      : const Color.fromARGB(255, 37, 100, 235), // blue
                  elevation: getxObj.darkMode.value ? 6 : 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // pill shape
                  ),
                  side: BorderSide(
                    color: getxObj.darkMode.value
                        ? Colors.blue.withOpacity(0.4)
                        : Colors.blue,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: const [
                    Text(
                      "Submit Feed Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.send, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitFeedBack() async {
    if (!_formKey.currentState!.validate()) {
      showSnackbarFunction(
        context,
        "Please Write your Opinion",
        Colors.deepOrange,
        Icons.info,
      );
    } else if (getxObj.starFeedback.value == -1) {
      showSnackbarFunction(
        context,
        "Please give a rating ⭐",
        Colors.deepOrange,
        Icons.info,
      );
    } else {
      // 1. Capture the values FIRST before resetting
      final int selectedRating = getxObj.starFeedback.value;
      final String feedbackText = textController.text;
      _textFocus.unfocus();

      // 3. Save to SharedPreferences using the captured variables
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setBool("feedBackSubmited", true);
      await sp.setInt("rating", selectedRating);
      await sp.setString("text", feedbackText);
      _formKey.currentState!.reset();
      textController.clear();
      getxObj.starFeedback.value = -1;
      Get.off(
        () => const SubmitedFeedback(),
        transition: Transition.leftToRight,
      );
    }
  }
}
