import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGetxController extends GetxController {
  Rx<XFile?> imagePickimageGetx = Rx<XFile?>(null);
  Rx<XFile?> imagePickimageProfileGetx = Rx<XFile?>(null);
  RxBool saveProfileImage = false.obs;
  RxString base64ImageString = "".obs;
  RxBool loaderGetx = false.obs;
  RxString giminiReplyScanGetx = "".obs;


  Future imagePickGallery() async {
    final imagePick = ImagePicker();
    final image = await imagePick.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePickimageGetx.value = image;
      return image;
    }
  }

  Future imagePickCamera() async {
    final imagePick = ImagePicker();
    final image = await imagePick.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePickimageGetx.value = image;
      return image;
    }
  }

  Future base64ImageStringFunction(fileValue) async {
    final byteCode = await fileValue.readAsBytes();
    String base64 = base64Encode(byteCode);
    base64ImageString.value = base64;
    return base64;
  }
}
