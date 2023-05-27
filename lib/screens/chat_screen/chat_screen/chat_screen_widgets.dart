import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/chat_screen_controller.dart';
import '../../../model/chat_screens_models/chat_list_model.dart';

class ChatScreenWidgets extends StatelessWidget {
  ChatScreenWidgets({super.key});

  final screenController = Get.find<ChatScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.network(
              screenController.personData.images.isNotEmpty
                  ? screenController.personData.images[0].imageUrl.toString()
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
        /*Container(
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: AppColors.darkOrangeColor,
            ),
            image: const DecorationImage(
              image: AssetImage(
                AppImages.swiper1Image,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),*/
        SizedBox(height: 2.h),
        Text(
          "${screenController.personData.name}, ${screenController.personData.age}",
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplaySemibold,
            textColor: AppColors.grey800Color,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          "You’re friends on Gather",
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayMedium,
            textColor: AppColors.grey600Color,
            fontSize: 15.sp,
          ),
        ),
        /*SizedBox(height: 1.h),
        Text(
          "Lives in ${screenController.personData.}",
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.grey400Color,
            fontSize: 13.sp,
          ),
        ),*/
        screenController.chatList.isEmpty ? SizedBox(height: 4.h) : Container(),
        screenController.chatList.isEmpty
            ? Text(
                "Say hi to your new Gather friend, ${screenController.personData.name}.",
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplayMedium,
                  textColor: AppColors.grey600Color,
                  fontSize: 13.sp,
                ),
              )
            : Container(),
        // const Spacer(),
      ],
    );
  }
}

class TextFormFieldModule extends StatelessWidget {
  TextFormFieldModule({super.key});

  final chatScreenController = Get.find<ChatScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 35,
            decoration: const BoxDecoration(
              color: AppColors.grey200Color,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    chatScreenController.isEmojiVisible.value =
                        !chatScreenController.isEmojiVisible.value;
                    chatScreenController.focusNode.unfocus();
                    chatScreenController.focusNode.canRequestFocus = true;
                  },
                  child: Image.asset(AppImages.emojiImage),
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: chatScreenController.focusNode,
                    controller: chatScreenController.textEditingController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: AppMessages.typeAMessage,
                      hintStyle: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey400Color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (chatScreenController.textEditingController.text
                .trim()
                .isNotEmpty) {
              await chatScreenController.sendChatMessageFunction();
            }
          },
          icon: Image.asset(AppImages.locationImage),
        ),
      ],
    ).commonSymmetricPadding(horizontal: 60, vertical: 4);
  }
}

class MessageAllModule extends StatelessWidget {
  MessageAllModule({Key? key}) : super(key: key);
  final screenController = Get.find<ChatScreenController>();

  @override
  Widget build(BuildContext context) {
    // bool isMe = false;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // reverse: true,
      itemCount: screenController.chatList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        ChatData singleChat = screenController.chatList[index];
        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: singleChat.clientMessage == true
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  singleChat.clientMessage == false
                      ? screenController.personData.images.isNotEmpty
                          ? CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(screenController
                                  .personData.images[0].imageUrl),
                            )
                          : const CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage(AppImages.swiper1Image),
                            )
                      : Container(),
                  // const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    decoration: BoxDecoration(
                        color: singleChat.clientMessage == true
                            ? AppColors.lightOrangeColor
                            : AppColors.whiteColor2,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          //bottomRight: Radius.circular(20),
                        )),
                    child: Text(
                      singleChat.messageText,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayMedium,
                        textColor: singleChat.clientMessage == true
                            ? AppColors.whiteColor2
                            : AppColors.grey600Color,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              /*SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: singleChat.clientMessage == false ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if(singleChat.clientMessage)
                      SizedBox(width: 10.w),
                     Text('10.00 AM',
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey400Color,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),*/
            ],
          ),
        );
      },
      /*separatorBuilder: (BuildContext context, int index) {
        return Center(
          child: Container(
            height: 30,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
                borderRadius:  BorderRadius.all(
                  Radius.circular(30)
                ),
            ),
            child: Center(
              child: Text('Monday',
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.lightOrangeColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ).commonSymmetricPadding(horizontal: 130),
        );
    },*/
    ).commonSymmetricPadding(horizontal: 20);
  }
}

class EmojiVisible extends StatelessWidget {
  EmojiVisible({Key? key}) : super(key: key);
  final chatScreenController = Get.find<ChatScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Offstage(
        offstage: !chatScreenController.isEmojiVisible.value,
        child: SizedBox(
          height: 250,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              chatScreenController.textEditingController.text =
                  chatScreenController.textEditingController.text + emoji.emoji;
            },
            //textEditingController: chatScreenController.textEditingController,
            config: const Config(
              columns: 7,
              //verticalSpacing: 0,
              // horizontalSpacing: 0,
              // gridPadding: EdgeInsets.zero,
              // initCategory: Category.RECENT,
              // bgColor: Color(0xFFF2F2F2),
              // indicatorColor: Colors.blue,
              // iconColor: Colors.grey,
              // iconColorSelected: Colors.blue,
              // backspaceColor: Colors.blue,
              //skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              //enableSkinTones: true,
              //showRecentsTab: true,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            ),
          ),
        ),
      ),
    );
  }
}
