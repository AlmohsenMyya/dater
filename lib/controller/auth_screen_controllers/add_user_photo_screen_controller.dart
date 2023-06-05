import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dater/constants/api_url.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/authentication_screen/dob_select_screen/dob_select_screen.dart';
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
  File image1 = File("");
  File image2 = File("");
  File image3 = File("");
  String image1Name = "";
  String image2Name = "";
  String image3Name = "";
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
        if (index == 0) {
          File tempImg = File(pickedFile.path);
          if (tempImg.lengthSync() <= 2000000) {
            image1 = tempImg;
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
              image1 = File(pickedFile.path);
            }
          }
        } else if (index == 1) {
          File tempImg = File(pickedFile.path);
          if (tempImg.lengthSync() <= 2000000) {
            image2 = tempImg;
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
              image2 = File(pickedFile.path);
            }
          }
        } else if (index == 2) {
          File tempImg = File(pickedFile.path);
          if (tempImg.lengthSync() <= 2000000) {
            image3 = tempImg;
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
              image3 = File(pickedFile.path);
            }
          }
        }
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
    isLoading(true);
    if (image1.path.isEmpty || image2.path.isEmpty || image3.path.isEmpty) {
      Fluttertoast.showToast(msg: "Please select three photo");
    } else {
      image1Name = image1.path.toString().split("/").last;
      image2Name = image2.path.toString().split("/").last;
      image3Name = image3.path.toString().split("/").last;

      log('image1Name : $image1Name');
      log('image2Name : $image2Name');
      log('image3Name : $image3Name');

      // await uploadImageFunction();

      if (image1.path != "") {
        await signUpPreference.setStringValueInPrefs(
          key: SignUpPreference.userImage1Key,
          value: image1.path.toString(),
        );
        await uploadImageFunction(image1);
      }
      if (image2.path != "") {
        await signUpPreference.setStringValueInPrefs(
          key: SignUpPreference.userImage2Key,
          value: image2.path.toString(),
        );
        await uploadImageFunction(image2);
      }
      if (image3.path != "") {
        await signUpPreference.setStringValueInPrefs(
          key: SignUpPreference.userImage3Key,
          value: image3.path.toString(),
        );
        await uploadImageFunction(image3);
      }
      // log('Image upload Status final :$isImageUploadInApiSuccess');
      // log('Image upload Status 1 :$isImageUploadInApiSuccess');

      Timer(
        const Duration(milliseconds: 500),
        () {
          if (isImageUploadInApiSuccess == true) {
            Get.to(() => DobSelectScreen());
          } else {
            Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
          }
        },
      );
    }
    isLoading(false);
  }

  // Upload Image function
  Future<void> uploadImageFunction(File image) async {
    isLoading(true);
    String url = ApiUrl.uploadPhotoApi;
    try {
      // Map<String, dynamic> headerData = {
      //   "fileKey" : "file",
      //   "chunkedMode": false,
      //   "mimeType": "multipart/form-data"
      // };
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
      log('Upload Image response : ${response.data}');

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
