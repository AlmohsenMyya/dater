import 'package:dater/utils/preferences/signup_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authentication_screen/add_user_photo_screen/add_user_photo_screen.dart';

class UserNameScreenController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextFieldController = TextEditingController();

  SignUpPreference signUpPreference = SignUpPreference();

  Future<void> confirmButtonFunction() async {
    if(formKey.currentState!.validate()) {
      await signUpPreference.setStringValueInPrefs(
        key: SignUpPreference.signUpFNameKey,
        value: nameTextFieldController.text.trim(),
      );

      Get.to(()=> AddUserPhotoScreen());
    }
  }
}