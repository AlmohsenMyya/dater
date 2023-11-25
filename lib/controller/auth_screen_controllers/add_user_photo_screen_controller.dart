import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dater/constants/api_url.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/authentication_screen/dob_select_screen/dob_select_screen.dart';
import 'package:dater/utils/functions.dart';
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/authentication_model/add_user_photo_screen_model/user_photo_upload_screen.dart';
import '../../utils/preferences/signup_preference.dart';

class AddUserPhotoScreenController extends GetxController {
  RxBool isLoading = false.obs;

  final ImagePicker picker = ImagePicker();

  // File image1 = File("");
  // File image2 = File("");
  // File image3 = File("");
  // String image1Name = "";
  // String image2Name = "";
  // String image3Name = "";
  List<File> imagesNew = [
    File(""),
    File(""),
    File(""),
  ];
  List<bool> uploadedSuccessfully = [false, false, false];
  bool isImageUploadInApiSuccess = false;
  SignUpPreference signUpPreference = SignUpPreference();
  UserPreference userPreference = UserPreference();

  var dioRequest = dio.Dio();

  pickImageFromGallery(int index) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        for (int i = 0; i < 3; i++) {
          if (index == i) {
            File tempImg = File(pickedFile.path);
            if (tempImg.lengthSync() <= 2000000) {
              imagesNew[i] = tempImg;
            } else {
              Fluttertoast.showToast(
                  msg:
                      'Re-choose the photo if you want to compress it because it exceeds 2MB in size');
              XFile? pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 480,
                  maxWidth: 640,
                  imageQuality: 50);
              if (pickedFile != null) {
                imagesNew[i] = File(pickedFile.path);
              }
            }
            printAll(name: 'sizeImage', imagesNew[i].lengthSync());
          }
        }
        // if (index == 0) {
        //   File tempImg = File(pickedFile.path);
        //   if (tempImg.lengthSync() <= 2000000) {
        //     image1 = tempImg;
        //   } else {
        //     Fluttertoast.showToast(
        //         msg:
        //             'Re-choose the photo if you want to compress it because it exceeds 2MB in size');
        //     XFile? pickedFile = await ImagePicker().pickImage(
        //         source: ImageSource.gallery,
        //         maxHeight: 480,
        //         maxWidth: 640,
        //         imageQuality: 50);
        //     if (pickedFile != null) {
        //       image1 = File(pickedFile.path);
        //     }
        //   }
        //   printAll(name: 'sizeImage', image1.lengthSync());
        // }
        // else if (index == 1) {
        //   File tempImg = File(pickedFile.path);
        //   if (tempImg.lengthSync() <= 2000000) {
        //     image2 = tempImg;
        //   } else {
        //     Fluttertoast.showToast(
        //         msg:
        //             'Re-choose the photo if you want to compress it because it exceeds 2MB in size');
        //     XFile? pickedFile = await ImagePicker().pickImage(
        //         source: ImageSource.gallery,
        //         maxHeight: 480,
        //         maxWidth: 640,
        //         imageQuality: 50);
        //     if (pickedFile != null) {
        //       image2 = File(pickedFile.path);
        //     }
        //   }
        //   printAll(name: 'sizeImage', image2.lengthSync());
        // }
        // else if (index == 2) {
        //   File tempImg = File(pickedFile.path);
        //   if (tempImg.lengthSync() <= 2000000) {
        //     image3 = tempImg;
        //   } else {
        //     Fluttertoast.showToast(
        //         msg:
        //             'Re-choose the photo if you want to compress it because it exceeds 2MB in size');
        //     XFile? pickedFile = await ImagePicker().pickImage(
        //         source: ImageSource.gallery,
        //         maxHeight: 480,
        //         maxWidth: 640,
        //         imageQuality: 50);
        //     if (pickedFile != null) {
        //       image3 = File(pickedFile.path);
        //     }
        //   }
        //   printAll(name: 'sizeImage', image3.lengthSync());
        // }
      }
    } catch (e) {
      log('');
      rethrow;
    }
    isLoading(true);
    isLoading(false);
  }

  // Photo Save button function
  Future<void> doneButtonFunction() async {
    for (int i = 0; i < 3; i++) {
      if (imagesNew[i].path.isEmpty) {
        Fluttertoast.showToast(msg: "Please select three photos");
        return;
      }
    }
    isLoading(true);
    for (int i = 0; i < 3; i++) {
      String imagesName = '';
      imagesName = imagesNew[i].path.toString().split("/").last;
      log('image-Name-$i : $imagesName');

      try {
        if (imagesName != '' && !uploadedSuccessfully[i]) {
          await uploadImageFunction(imagesNew[i]);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error, try another image');
        isLoading(false);
        imagesNew[i] = File('');
        uploadedSuccessfully[i] = false;
        return;
      }
      uploadedSuccessfully[i] = true;
    }

    Timer(
      const Duration(milliseconds: 200),
      () {
        if (isImageUploadInApiSuccess == true) {
          Get.to(() => DobSelectScreen());
          isLoading(false);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      },
    );
    isLoading(false);
  }

// Upload Image function
  Future<void> uploadImageFunction(File image) async {
    isLoading(true);
    String url = ApiUrl.uploadPhotoApi;
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        "file": await dio.MultipartFile.fromFile(image.path,
            filename: image.path.toString().split("/").last),
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

      UserPhotoUploadModel userPhotoUploadModel =
          UserPhotoUploadModel.fromJson(json.decode(response.data));

      if (userPhotoUploadModel.statusCode == 200) {
        log('Image upload Status 1 :$isImageUploadInApiSuccess');
        isImageUploadInApiSuccess = true;
        log('Image upload Status 2 :$isImageUploadInApiSuccess');
        // Get.to(() => DobSelectScreen());
      } else if (userPhotoUploadModel.statusCode == 400) {
        Fluttertoast.showToast(msg: userPhotoUploadModel.msg);
      } else {
        Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
      }

      /*var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['fileKey'] = "file";
      request.headers['chunkedMode'] = "false";
      request.headers['mimeType'] = "multipart/form-data";
      request.fields['token'] = verifyToken;
      request.files.add(await http.MultipartFile.fromPath("file", image.path));

      log('All Fields : ${request.fields}');
      log('All files : ${request.files}');
      log('All headers : ${request.headers}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value :$value');
        UserPhotoUploadModel userPhotoUploadModel = UserPhotoUploadModel.fromJson(json.decode(value));

        if(userPhotoUploadModel.statusCode == 200) {
          log('Image upload Status 1 :$isImageUploadInApiSuccess');
          isImageUploadInApiSuccess = true;
          log('Image upload Status 2 :$isImageUploadInApiSuccess');
        } else if(userPhotoUploadModel.statusCode == 400) {
          Fluttertoast.showToast(msg: userPhotoUploadModel.msg);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });*/
    } catch (e) {
      log('uploadImageFunction Error :$e');
      rethrow;
    }
  }
}
