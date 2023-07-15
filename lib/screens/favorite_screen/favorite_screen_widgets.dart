import 'dart:ui';

import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/favorite_screen_controller.dart';
import 'package:dater/screens/favorite_screen/remove_blur_dialog.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_images.dart';
import '../../model/favorite_screen_model/liker_model.dart';
import '../../utils/style.dart';

class FavoriteGridViewBuilderModule extends StatelessWidget {
  FavoriteGridViewBuilderModule({Key? key}) : super(key: key);
  final favoriteScreenController = Get.find<FavoriteScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          favoriteScreenController.initMethod();
        },
        child: GridView.builder(
          itemCount: favoriteScreenController.likerList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 19,
            mainAxisSpacing: 19,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            LikerData singleData = favoriteScreenController.likerList[index];

            return InkWell(
              // onT ap: () => showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return Obx(
              //         () => CustomAlertDialog(
              //           text: 'See who likes you',
              //           content: 'Every profile will cost 1 coin',
              //           buttonText: 'UnderStand',
              //           value: favoriteScreenController.isShowAgain.value == "no" ? LikesDialogShow.no.name : LikesDialogShow.yes.name,
              //           groupValue: favoriteScreenController.isShowAgain.value.toString(),
              //           onPressed: () {
              //             Get.back();
              //           },
              //           onChanged: (value) {
              //             log("value 111 : $value");
              //             favoriteScreenController.isLoading(true);
              //             if(favoriteScreenController.isShowAgain.value == "no") {
              //               favoriteScreenController.isShowAgain.value = "yes";
              //             } else {
              //               favoriteScreenController.isShowAgain.value = "no";
              //             }
              //             // favoriteScreenController.isShowAgain.value = value!;
              //             favoriteScreenController.isLoading(false);
              //             log("value 222 : $value");
              //           },
              //           activeColor: AppColors.darkOrangeColor,
              //           radioButtonText: "don't show again",
              //         ),
              //       );
              //     }),
              onTap: () {
                if (!singleData.visible) {
                  // favoriteScreenController.removeBlur(index);
                  Get.dialog(RemoveBlurDialog(
                    removeBlurIndex: index,
                  ));
                } else {
                  favoriteScreenController.backWithLike(index);

                  // Get.to(() => LikerDetailsScreen(), arguments: [
                  //                     favoriteScreenController.likerList[index].id
                  //                   ])!
                }
              },
              child: Container(
                // height: 30.h,
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [BoxShadow(blurRadius: 1)]),
                child: Column(
                  children: [
                    Expanded(
                      flex: 85,
                      child: singleData.images.isNotEmpty
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    singleData.images[0].imageUrl,
                                  ),
                                )),
                                child: Visibility(
                                  visible: !favoriteScreenController
                                      .likerList[index].visible,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 12.0, sigmaY: 12.0),
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white.withOpacity(0.0)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image.asset(
                                AppImages.appIcon,
                              ).commonAllSidePadding(30),
                            ),
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      flex: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            width: 2.8.w,
                            height: 1.5.h,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            duration: const Duration(seconds: 0),
                            //curve: Curves.bounceIn,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            singleData.activeTime,
                            //textAlign: TextAlign.right,
                            style: TextStyleConfig.textStyle(
                              textColor: AppColors.grey800Color,
                              fontSize: 12.sp,
                              fontFamily: FontFamilyText.sFProDisplaySemibold,
                              // fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
