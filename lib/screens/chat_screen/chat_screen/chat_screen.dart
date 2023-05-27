import 'dart:developer';

import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/screens/chat_screen/chat_screen/chat_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_loader.dart';
import '../../../constants/app_images.dart';
import '../../../controller/chat_screen_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final chatScreenController = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        chatScreenController.isTimerOn.value = false;
        log('onWillPop isTimerOn :${chatScreenController.isTimerOn.value}');
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor2,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  chatScreenController.isTimerOn.value = false;
                  log('AppBar isTimerOn :${chatScreenController.isTimerOn.value}');
                  Get.back();
                },
                icon: const Icon(
                  Icons.west_outlined,
                  color: AppColors.lightOrangeColor,
                ),
              );
            },
          ),
          centerTitle: true,
          elevation: 0,
          title: Text(
            chatScreenController.personData.name,
            style: TextStyle(
              color: AppColors.grey800Color,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 20.sp,
            ),
          ),
          actions: [
            Obx(
              () => chatScreenController.isLoading.value
                  ? Container()
                  : Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Image.network(
                            chatScreenController.personData.images.isNotEmpty
                                ? chatScreenController
                                    .personData.images[0].imageUrl
                                    .toString()
                                : "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, st, obj) {
                              return Image.asset(
                                AppImages.chatimage,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        /*appBar: appBarModule(
          text: chatScreenController.personData.name,
          userImage: chatScreenController.personData.images.isNotEmpty
              ? chatScreenController.personData.images[0].imageUrl.toString()
              : "",
        ),*/
        body: WillPopScope(
          onWillPop: () {
            if (chatScreenController.isEmojiVisible.value) {
              chatScreenController.isEmojiVisible.value = false;
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Obx(
            () => chatScreenController.isLoading.value
                ? const CustomLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        //flex: 20,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  ChatScreenWidgets(),
                                  SizedBox(height: 5.h),
                                  MessageAllModule()
                                      .commonOnlyPadding(bottom: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor2,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(-3, -1),
                              color: AppColors.grey400Color,
                            ),
                          ],
                        ),
                        child: TextFormFieldModule(),
                      ),
                      EmojiVisible(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
