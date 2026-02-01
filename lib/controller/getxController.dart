import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voice_assistant/screens/internetCheck.dart';

class getController extends GetxController {
  RxList logInUserData = RxList(); //LogedIn User Data

  RxBool isListening = false.obs;
  RxString gminiAns = "".obs;
  RxString voiceText = "Listening...".obs;
  RxString statusData = "LISTENING".obs;
  RxBool speakingEnd = false.obs;
  RxInt selectVoice = 0.obs;
  RxInt selectMode = 0.obs;
  RxInt selectOutputLanguage = 0.obs;
  RxDouble volumnRangeSlider = 20.0.obs;
  RxInt selectAiSkillsCategory = 0.obs;
  RxString suggestiveQuestionOption = "All".obs;
  RxBool suggestiveQuestionOptionLoader = false.obs;
  RxBool chatBoldAiText = false.obs;
  RxBool chatBoldUserText = false.obs;
  RxBool chatAiTheme = true.obs;
  RxBool chatUserTheme = true.obs;
  RxInt backgroundColorsAiGetx = 0.obs;
  RxInt backgroundColorsUserGetx = 0.obs;
  RxInt textColorsAiGetx = 1.obs;
  RxInt textColorsUserGetx = 0.obs;
  RxDouble textSizeAiGetx = 15.0.obs;
  RxDouble textSizeUserGetx = 15.0.obs;

  // Assistance Screen
  RxDouble assistanceFontSizeGetx = 15.0.obs;
  RxBool assistanceFontBoldGetx = false.obs;
  RxBool assistanceThemeGetx = true.obs;
  RxInt backgroundColorsAssistanceGetx = 3.obs;
  RxInt textColorsAssistanceGetx = 0.obs;
  RxBool isMaleVoice = true.obs;

  get imagePickimageGetx => null;

  // RxDouble assistanceHeightContainer = 130.0.obs;
  //Translate
  RxString selectedLanguageSource = "English".obs;
  RxString selectedLanguageDestination = "Bengali".obs;
  RxString translateOutputText = "Translation....".obs;
  TextEditingController translateInputText = TextEditingController();

  //Settings
  RxBool darkMode = true.obs;
  RxBool dialogBoxOpen = false.obs;
  RxList<Widget> showListElementGetx = <Widget>[].obs;
  RxInt showListIndexGetx = (-1).obs;
  //LoginScreen
  RxBool passwordFlag = false.obs;
  RxBool confirmPasswordFlag = false.obs;
  RxBool loaderLoginGuest = false.obs;
  // FeedBack Screen
  RxList feedbackIndex = [0].obs;
  RxInt starFeedback = (-1).obs;
  //History
  RxList historyData = [].obs;
  RxList searchHistory = [].obs;
  RxBool checkInterNet = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    ever(checkInterNet, (bool hasInternet) {
      if (!hasInternet) {
        Get.to(
          () => const NetworkLostScreen(),
          transition: Transition.fade,
          routeName: '/network-lost',
        );
      } else {
        if (Get.currentRoute == '/network-lost') {
          Get.back();
        }
      }
    });
  }
}
