import 'package:dater/common_modules/custom_textfromfiled.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/all_chat_list_screen_controller.dart';
import 'package:dater/screens/chat_screen/chat_screen/chat_screen.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../model/home_screen_model/matches_model.dart';

class SearchTextfiledModule extends StatelessWidget {
  const SearchTextfiledModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allChatListScreenController = Get.find<AllChatListScreenController>();
    return Row(
      children: [
        Form(
          key: allChatListScreenController.formKey,
          child: Expanded(
            child: SizedBox(
              height: 5.7.h,
              child: Material(
                elevation: 9.0,
                shadowColor: AppColors.gray100Color,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormFiledCustom(
                  fieldController:
                      allChatListScreenController.searchTextFieldController,
                  hintText: AppMessages.search,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.grey400Color,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatListModule extends StatelessWidget {
  ChatListModule({super.key});

  final allChatListScreenController = Get.find<AllChatListScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.lightOrangeColor,
        onRefresh: () async {
          allChatListScreenController.initMethod();
        },
        child: ListView.builder(
          itemCount: allChatListScreenController.searchMatchesList.length,
          itemBuilder: (context, index) {
            MatchUserData person =
                allChatListScreenController.searchMatchesList[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => ChatScreen(), arguments: [person])!
                    .then((value) async {
                  await allChatListScreenController.getMatchesFunction();
                });
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: person.images.isNotEmpty
                        ? Image.network(
                            person.images[0].imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(AppImages.chatimage),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: person.name,
                        style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          textColor: AppColors.grey800Color,
                          fontSize: 14.sp,
                          fontWeight: person.lastMessage.isSeen == 1
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: person.verified == "1"
                            ? Image.asset(
                                AppImages.rightimage,
                                height: 30,
                                width: 30,
                              )
                            : SizedBox(
                                height: 30,
                                width: 30,
                              ),
                        // child: Image.asset(AppImages.rightimage, height: 30, width: 30,)
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  person.lastMessage.messageText,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    textColor: AppColors.grey800Color,
                    fontSize: 12.sp,
                    fontWeight: person.lastMessage.isSeen == 1
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: person.lastMessage.isSeen == 1
                            ? Colors.transparent
                            : AppColors.darkOrangeColor,
                      ),
                    ),
                    /*Text(
                      "9:27 AM",
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey500Color,
                      ),
                    ).commonOnlyPadding(top: 3),*/
                  ],
                ),
              ),
            );
            // return GestureDetector(
            //   onTap: () {
            //     Get.to(
            //       () => ChatScreen(),
            //     );
            //   },
            //   child: Row(
            //     children: [
            //       Stack(
            //         alignment: Alignment.bottomRight,
            //         children: [
            //           const CircleAvatar(
            //             backgroundImage: AssetImage(AppImages.chatimage),
            //           ),
            //           allChatListScreenController.activeSelected.value
            //               ? Container(
            //                   height: 15,
            //                   width: 15,
            //                   decoration: const BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     image: DecorationImage(
            //                       image: AssetImage(AppImages.activeImage),
            //                     ),
            //                   ),
            //                 )
            //               : Container(),
            //         ],
            //       ),
            //       SizedBox(width: 2.w),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               Text(
            //                 "Dennis Steele",
            //                 style: TextStyleConfig.textStyle(
            //                   fontFamily: FontFamilyText.sFProDisplaySemibold,
            //                   textColor: AppColors.grey800Color,
            //                   fontSize: 14.sp,
            //                 ),
            //               ),
            //               allChatListScreenController.rightSelected.value
            //                   ? Image.asset(AppImages.rightimage)
            //                   : Container(),
            //               allChatListScreenController.panddingMess.value
            //                   ? Container(
            //                       height: 10,
            //                       width: 10,
            //                       decoration: const BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         color: AppColors.darkOrangeColor,
            //                       ),
            //                     )
            //                   : Container(),
            //             ],
            //           ),
            //           // SizedBox(height: 0.5.h),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Hey, how’s life going.",
            //                 style: TextStyleConfig.textStyle(
            //                   fontFamily: FontFamilyText.sFProDisplayRegular,
            //                   textColor: AppColors.grey800Color,
            //                   fontSize: 12.sp,
            //                 ),
            //               ),
            //               Text("9:27 AM")
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ).commonOnlyPadding(bottom: 4.h),
            // );
          },
        ),
      ),
    );
  }
}
