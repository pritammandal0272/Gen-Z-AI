import 'package:get/get.dart';
import 'package:voice_assistant/controller/getxController.dart';

final getxObj = Get.find<getController>();
void filterSearch(value) {
  var result = getxObj.searchHistory.where(
    (item) =>
        item["userSms"].toString().toLowerCase().contains(value.toLowerCase()),
  );
  var l = [];
  l.addAll(result);
  getxObj.historyData.assignAll(l);
}
