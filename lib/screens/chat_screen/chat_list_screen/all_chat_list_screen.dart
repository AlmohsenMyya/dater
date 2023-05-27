import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/all_chat_list_screen_controller.dart';
import 'package:dater/screens/chat_screen/chat_list_screen/all_chat_list_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllChatListScreen extends StatelessWidget {
  AllChatListScreen({super.key});

  final allChatListScreenController = Get.put(AllChatListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.chat, isLeadingShow: false),
      body: /*allChatListScreenController.matchesList.isEmpty
          ? const Center(
              child: Text('No Matches Found!'),
            )
          : */
          Obx(
        () => allChatListScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
                children: [
                  const SearchTextfiledModule(),
                  SizedBox(height: 3.h),
                  allChatListScreenController.searchMatchesList.isEmpty
                      ? SizedBox(
                          height: 50.h,
                          child: const Center(
                            child: Text('No Matches Found'),
                          ),
                        )
                      : ChatListModule(),
                ],
              ).commonSymmetricPadding(horizontal: 25, vertical: 10),
      ),
    );
  }
}
