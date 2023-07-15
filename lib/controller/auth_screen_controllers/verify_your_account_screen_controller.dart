import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dater/constants/api_url.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/saved_data_model/saved_data_model.dart';
import '../../utils/preferences/user_preference.dart';

class VerifyYourAccountScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;
  final ImagePicker picker = ImagePicker();
  File userImage = File("");
  var imagePath = ''.obs;
  var dioRequest = dio.Dio();

  UserPreference userPreference = UserPreference();

  pickImageFromGallery(ImageSource imageSource) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: imageSource, preferredCameraDevice: CameraDevice.front);
      if (pickedFile != null) {
        userImage = File(pickedFile.path);
        imagePath.value = pickedFile.path;
      }
    } catch (e) {
      log('');
      rethrow;
    }
    // }
    // else {
    //   // Permissions not granted, handle the situation accordingly
    // }

    isLoading(true);
    isLoading(false);
  }

  Future<void> doneButtonFunction() async {
    if (imagePath.value != "") {
      await uploadUserSelfieFunction();
    } else {
      Fluttertoast.showToast(msg: "Please select your selfie image");
    }
  }

  Future<void> uploadUserSelfieFunction() async {
    isLoading(true);
    String url = ApiUrl.uploadVerificationPhotoApi;
    log('uploadUserSelfieFunction Api Url :$url');
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        "file": await dio.MultipartFile.fromFile(userImage.path,
            filename: userImage.path.toString().split("/").last),
      });
      var response = await dioRequest.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {
            "fileKey": "file",
            "chunkedMode": "false",
            "mimeType": "multipart/form-data",
          },
        ),
      );
      log('Upload Image response : ${response}');
      SavedDataModel savedDataModel =
          SavedDataModel.fromJson(json.decode(response.data));
      successStatus.value = savedDataModel.statusCode;

      if (successStatus.value == 200) {
        Fluttertoast.showToast(msg: savedDataModel.msg);
        // TODO: add pending verification status after upload the photo
        Get.back();
      } else {
        log('uploadUserSelfieFunction Else');
      }
    } catch (e) {
      log('uploadUserSelfieFunction Error :$e');
      rethrow;
    }
// String url = ApiUrl.setVerifiedApi;
// try {
//   String verifyToken = await userPreference.getStringFromPrefs(
//       key: UserPreference.userVerifyTokenKey);
//   var request = http.MultipartRequest('POST', Uri.parse(url));
//   request.fields['token'] = verifyToken;
//   request.fields['verified'] = "0";
//
//   log('Request Field : ${request.fields}');
//   var response = await request.send();
//
//   response.stream.transform(utf8.decoder).listen((value1) async {
//     log('value : $value1');
//     SavedDataModel savedDataModel =
//         SavedDataModel.fromJson(json.decode(value1));
//     successStatus.value = savedDataModel.statusCode;
//
//     if (successStatus.value == 200) {
//       Fluttertoast.showToast(msg: savedDataModel.msg);
//       Get.back();
//     } else {
//       log('uploadUserSelfieFunction Else');
//     }
//   });
// } catch (e) {
//   log('uploadUserSelfieFunction Error :$e');
//   rethrow;
// }
  }
}
