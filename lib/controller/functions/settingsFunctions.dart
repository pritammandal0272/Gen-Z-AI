import 'package:get/get.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/dataBase/updateValues.dart';
import 'package:voice_assistant/controller/getxController.dart';

final getxObj = Get.find<getController>();

// ignore: non_constant_identifier_names
void Initialize_Assistence_SettingsGetxVariable(data) {
  if (data[0]["Email_or_Phone"] != "") {
    getxObj.selectVoice.value = data[0]["Output_Voice"];
    getxObj.assistanceFontSizeGetx.value = (data[0]["Assist_FontSize"] as int)
        .toDouble();
    getxObj.assistanceFontBoldGetx.value =
        (data[0]["Assist_FontBold"] as int) == 1;
    getxObj.backgroundColorsAssistanceGetx.value = data[0]["Assist_bgColor"];
    getxObj.textColorsAssistanceGetx.value = data[0]["Assist_textColor"];

    if (data[0]["Output_Language"] == "english") {
      getxObj.selectOutputLanguage.value = 0;
    } else if (data[0]["Output_Language"] == "bengali") {
      getxObj.selectOutputLanguage.value = 1;
    } else if (data[0]["Output_Language"] == "hindi") {
      getxObj.backgroundColorsAssistanceGetx.value = 2;
    } else {
      getxObj.backgroundColorsAssistanceGetx.value = 3;
    }
  }
}

// ignore: non_constant_identifier_names
void Initialize_Chat_SettingsGetxVariable(data) {
  getxObj.chatBoldAiText.value = (data[0]["ChatAI_FontBold"] as int) == 1;
  getxObj.chatBoldUserText.value = (data[0]["ChatUser_FontBold"] as int) == 1;
  getxObj.backgroundColorsAiGetx.value = data[0]["ChatAI_bgColor"];
  getxObj.backgroundColorsUserGetx.value = data[0]["ChatUser_bgColor"];
  getxObj.textColorsAiGetx.value = data[0]["ChatAI_textColor"];
  getxObj.textColorsUserGetx.value = data[0]["ChatUser_textColor"];
  getxObj.textSizeAiGetx.value = (data[0]["ChatAI_FontSize"] as int).toDouble();
  getxObj.textSizeUserGetx.value = (data[0]["ChatUser_FontSize"] as int)
      .toDouble();
}

Future<bool> saveSettingsAssistance(
  voice,
  language,
  fontSize,
  fontBold,
  bgColor,
  textColor,
  mode,
) async {
  if (voice == getxObj.logInUserData[0]["Output_Voice"] &&
      language == getxObj.logInUserData[0]["Output_Language"] &&
      fontSize == (getxObj.logInUserData[0]["Assist_FontSize"] as int) &&
      fontBold == (getxObj.logInUserData[0]["Assist_FontBold"] as int) &&
      bgColor == getxObj.logInUserData[0]["Assist_bgColor"] &&
      textColor == getxObj.logInUserData[0]["Assist_textColor"] &&
      mode == getxObj.logInUserData[0]["SelectMode"]) {
    return false;
  } else {
    await UpdateAssistSettings(
      getxObj.logInUserData[0]["Email_or_Phone"],
      voice,
      language,
      fontSize,
      fontBold,
      bgColor,
      textColor,
      mode,
    );
    final updatedData = await logInuserData(
      getxObj.logInUserData[0]["Email_or_Phone"],
    );
    getxObj.logInUserData.assignAll(updatedData);
    Initialize_Assistence_SettingsGetxVariable(updatedData);
    return true;
  }
}

Future<bool> saveSettingsChat(
  aiFontSize,
  aiFontBold,
  aiBgColor,
  userFontSize,
  userFontBold,
  userBgColor,
  userTextColor,
) async {
  if (aiFontSize == (getxObj.logInUserData[0]["ChatAI_FontSize"] as int) &&
      aiFontBold == (getxObj.logInUserData[0]["ChatAI_FontBold"] as int) &&
      aiBgColor == (getxObj.logInUserData[0]["ChatAI_bgColor"] as int) &&
      userFontSize == (getxObj.logInUserData[0]["ChatUser_FontSize"] as int) &&
      userFontBold == (getxObj.logInUserData[0]["ChatUser_FontBold"] as int) &&
      userBgColor == (getxObj.logInUserData[0]["ChatUser_bgColor"] as int) &&
      userTextColor ==
          (getxObj.logInUserData[0]["ChatUser_textColor"] as int)) {
    return false;
  } else {
    await updateChatSettings(
      getxObj.logInUserData[0]["Email_or_Phone"],
      aiFontSize,
      aiFontBold,
      aiBgColor,
      userFontSize,
      userFontBold,
      userBgColor,
      userTextColor,
    );
    final updatedData = await logInuserData(
      getxObj.logInUserData[0]["Email_or_Phone"],
    );
    getxObj.logInUserData.assignAll(updatedData);
    Initialize_Chat_SettingsGetxVariable(updatedData);
    return true;
  }
}
