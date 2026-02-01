import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/auth/giminiApi.dart';
import 'package:voice_assistant/controller/formatGiminiText.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/controller/imagePicker.dart';
import 'package:voice_assistant/screens/historyScreen/view/historyScreen.dart';
import 'package:voice_assistant/screens/homeScreen.dart';
import 'package:voice_assistant/screens/scannerScreen/controller/saveHistory.dart';
import 'package:voice_assistant/widgets/snackBar.dart';
import 'package:voice_assistant/widgets/textToSpeetch.dart';

class AiScanner extends StatefulWidget {
  final Map data;
  const AiScanner({super.key, required this.data});

  @override
  State<AiScanner> createState() => _AiScannerState();
}

final imagePickerController = Get.put(ImagePickerGetxController());
final getxObj = Get.find<getController>();
final tts = Texttospeetch();
var speakFlag = false;

class _AiScannerState extends State<AiScanner> {
  bool chekClickButton = false;
  var giminiReply = "";
  final _scrollController = ScrollController();

  Timer? _timer;
  void animateTypingText(stringValue) {
    _timer?.cancel();
    int index = 0;
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (index < stringValue.length) {
        imagePickerController.giminiReplyScanGetx.value += stringValue[index];
        index++;
        _autoScrollController();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _autoScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void initState() {
    if (widget.data["imageURL"] != "") {
      imagePickerController.imagePickimageGetx.value = XFile(
        widget.data["imageURL"],
      );
      imagePickerController.giminiReplyScanGetx.value =
          widget.data["aiScanerReply"];
    }
    log(widget.data.toString());
    super.initState();
  }

  @override
  void dispose() {
    imagePickerController.imagePickimageGetx.value = null;
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _stopTyping() {
    _timer?.cancel();
    setState(() {
      imagePickerController.giminiReplyScanGetx.value = giminiReply;
      _autoScrollController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final getxObj = Get.find<getController>();
    final colorsScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: TextGradiate(
          text: Text(
            "AI Scanner",
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
        actions: [
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                if (getxObj.logInUserData[0]["Email_or_Phone"] == "") {
                  ShowPopover(context);
                } else {
                  Get.off(
                    () => HistoryScreen(historyType: "Scanner History"),
                    transition: Transition.rightToLeft,
                  );
                }
              },
              child: Icon(Icons.history),
            ),
          ),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _stopTyping();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      // LAYER 1: IMAGE CONTAINER
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(31, 55, 174, 1),
                            width: 1,
                          ),
                          color: const Color.fromARGB(144, 158, 158, 158),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(31, 55, 174, 0.377),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child:
                            imagePickerController.imagePickimageGetx.value !=
                                null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(
                                    imagePickerController
                                        .imagePickimageGetx
                                        .value!
                                        .path,
                                  ),

                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: AssetImage("assets/scanImg.jpg"),
                                  fit: BoxFit.cover,
                                  // Keep fixed height ONLY for the placeholder
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                ),
                              ),
                      ),

                      if (imagePickerController.loaderGetx.value)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(113, 0, 0, 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                      if (imagePickerController.imagePickimageGetx.value ==
                              null ||
                          imagePickerController.loaderGetx.value)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final h = constraints.maxHeight;
                                return Stack(
                                  children: [
                                    Container(
                                          height: 4,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Color(0xFF00F2FF),
                                                Colors.transparent,
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                  142,
                                                  0,
                                                  242,
                                                  255,
                                                ).withOpacity(0.2),
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                        )
                                        .animate(
                                          onPlay: (controller) =>
                                              controller.repeat(reverse: true),
                                        )
                                        .moveY(
                                          begin: 0,
                                          end:
                                              h, // Moves exactly to bottom of image
                                          duration: NumDurationExtensions(
                                            5,
                                          ).seconds,
                                          curve: Curves.linear,
                                        ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),

                      if (!imagePickerController.loaderGetx.value &&
                          imagePickerController.imagePickimageGetx.value ==
                              null)
                        Center(
                          child: Container(
                            width: 250,
                            height: 60,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color.fromRGBO(31, 55, 174, 1),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(31, 55, 174, 1),
                                  offset: Offset(0, 0),
                                  blurRadius: 3,
                                ),
                              ],
                              color: colorsScheme.surface,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 5,
                              children: [
                                Row(
                                  spacing: 6,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AvatarGlow(
                                      glowColor: Colors.greenAccent,
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color.fromARGB(
                                            209,
                                            105,
                                            240,
                                            175,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "UPLOAD IMAGES",
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "SCAN AND DECTEING TEXT",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      if (imagePickerController.imagePickimageGetx.value ==
                          null)
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(14, 0, 0, 0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 15,
                                children: [
                                  // CAMERA BUTTON
                                  InkWell(
                                    onTap: () {
                                      onTabChosseCammeraImage();
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          color: const Color.fromARGB(
                                            137,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // GALLERY BUTTON
                                  InkWell(
                                    onTap: () {
                                      onTabChosseGalaryImage();
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            300,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          color: const Color.fromARGB(
                                            137,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ACTION BUTTONS
                SizedBox(
                  height: 120,
                  child: Row(
                    spacing: 10,
                    children: [
                      // RESET BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            imagePickerController.imagePickimageGetx.value =
                                null;
                            imagePickerController.giminiReplyScanGetx.value =
                                "";
                            _timer?.cancel();
                            if (getxObj.speakingEnd.value) {
                              await tts.stopSpeak();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            height: 130,
                            decoration: BoxDecoration(
                              color: colorsScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: BoxBorder.all(
                                color: Colors.red.withAlpha(80),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 7,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    minimumSize: Size.zero,
                                    elevation: 0,
                                    backgroundColor: const Color.fromARGB(
                                      57,
                                      244,
                                      67,
                                      54,
                                    ),
                                    iconSize: 26,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(300),
                                      side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  onPressed: () {},
                                  label: Icon(
                                    Icons.restore_page_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  "Reset",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _speakText(
                              imagePickerController.giminiReplyScanGetx.value,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            height: 130,
                            decoration: BoxDecoration(
                              color: colorsScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(168, 85, 247, 1),
                                  offset: Offset(0, 0),
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 7,
                              children: [
                                Obx(
                                  () => ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                      minimumSize: Size.zero,
                                      elevation: 0,
                                      backgroundColor: getxObj.speakingEnd.value
                                          ? const Color.fromARGB(
                                              68,
                                              33,
                                              149,
                                              243,
                                            )
                                          : Color.fromRGBO(168, 85, 247, 0.373),
                                      iconSize: 26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          300,
                                        ),
                                        side: BorderSide(
                                          color: getxObj.speakingEnd.value
                                              ? Colors.blue
                                              : Color.fromRGBO(168, 85, 247, 1),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    label: Icon(
                                      getxObj.speakingEnd.value
                                          ? Icons.volume_up
                                          : Icons.volume_mute,
                                      color: getxObj.speakingEnd.value
                                          ? Colors.blue
                                          : Color.fromRGBO(168, 85, 247, 1),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    getxObj.speakingEnd.value
                                        ? "Stop"
                                        : "Speak",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // TRANSLATE BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showSnackbarFunction(
                              context,
                              "Please Choose Image!",
                              Colors.red,
                              Icons.info_outline_rounded,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            height: 130,
                            decoration: BoxDecoration(
                              color: colorsScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(26, 189, 134, 1),
                                  offset: Offset(0, 0),
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 7,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    elevation: 0,
                                    minimumSize: Size.zero,
                                    backgroundColor: Color.fromRGBO(
                                      26,
                                      189,
                                      134,
                                      0.373,
                                    ),
                                    iconSize: 26,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(300),
                                      side: BorderSide(
                                        color: Color.fromRGBO(26, 189, 134, 1),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  label: Icon(
                                    Icons.translate,
                                    color: Color.fromRGBO(26, 189, 134, 1),
                                  ),
                                ),
                                Text(
                                  "Translate",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Obx(() {
                    return imagePickerController.loaderGetx.value
                        ? CircularProgressIndicator()
                        : imagePickerController.giminiReplyScanGetx.value == ""
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(86, 96, 125, 139),
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: formatGiminiText(
                              imagePickerController.giminiReplyScanGetx.value,
                              15,
                              false,
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTabChosseGalaryImage() async {
    if (chekClickButton) {
      showSnackbarFunction(context, "Wait....", Colors.teal, Icons.info);
      Timer(Duration(seconds: 3), () {
        chekClickButton = false;
      });
    } else {
      chekClickButton = true;
      final image = await imagePickerController.imagePickGallery();
      if (image != null) {
        showSnackbarFunction(
          context,
          "Image Uploaded Successfully",
          Colors.blue,
          Icons.check_circle_rounded,
        );
        imagePickerController.loaderGetx.value = true;
        final base64StringImage = await imagePickerController
            .base64ImageStringFunction(
              imagePickerController.imagePickimageGetx.value,
            );
        giminiReply = await giminiData(
          base64StringImage,
          "image",
          "Write Details of this image in Simple Words",
        );
        final DateTime aiTime = DateTime.now();
        await saveScnnerHistory(
          getxObj.logInUserData[0]["UserId"],
          imagePickerController.imagePickimageGetx.value!.path,
          giminiReply,
          DateFormat('MM/dd/yyyy h:mm a').format(aiTime),
        );
        imagePickerController.loaderGetx.value = false;
        animateTypingText(giminiReply);
      } else {
        showSnackbarFunction(
          context,
          "Failed image Uploaded",
          Colors.red,
          Icons.info,
        );
      }
    }
  }

  void onTabChosseCammeraImage() async {
    if (chekClickButton) {
      showSnackbarFunction(context, "Wait....", Colors.teal, Icons.info);
      Timer(Duration(seconds: 3), () {
        chekClickButton = false;
      });
    } else {
      chekClickButton = true;
      final image = await imagePickerController.imagePickCamera();
      if (image != null) {
        showSnackbarFunction(
          context,
          "Image Uploaded Successfully",
          Colors.blue,
          Icons.check_circle_rounded,
        );
        imagePickerController.loaderGetx.value = true;
        final base64StringImage = await imagePickerController
            .base64ImageStringFunction(
              imagePickerController.imagePickimageGetx.value,
            );
        giminiReply = await giminiData(
          base64StringImage,
          "image",
          "Write Details of this image in Simple Words",
        );
        // final DateTime aiTime = DateTime.now();
        // await saveScnnerHistory(
        //   getxObj.logInUserData[0]["UserId"],
        //   imagePickerController.imagePickimageGetx.value!.path,
        //   giminiReply,
        //   DateFormat('MM/dd/yyyy h:mm a').format(aiTime),
        // );
        imagePickerController.loaderGetx.value = false;
        animateTypingText(giminiReply);
      } else {
        showSnackbarFunction(
          context,
          "Failed image Uploaded",
          Colors.red,
          Icons.info,
        );
      }
    }
  }
}

void _speakText(data) async {
  speakFlag = !speakFlag;
  if (imagePickerController.loaderGetx.value) {
    await tts.speakText("Wait dear Loader in Running");
  } else if (imagePickerController.imagePickimageGetx.value == null) {
    await tts.speakText("Please Dear Upload Image");
  } else {
    if (speakFlag) {
      await tts.speakText(data);
    } else {
      await tts.stopSpeak();
    }
  }
}
