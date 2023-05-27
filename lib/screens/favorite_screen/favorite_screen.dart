import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/messages.dart';
import '../../controller/favorite_screen_controller.dart';
import '../../utils/style.dart';
import 'favorite_screen_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final favoriteScreenController = Get.put(FavoriteScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200Color,
      body: Obx(
        () => favoriteScreenController.isLoading.value
            ? const CustomLoader()
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonCustom(
                          backgroundColor: AppColors.lightOrangeColor,
                          shadowColor: Colors.blueGrey,
                          text: "${favoriteScreenController.likerList.length} Likes",
                          textColor: AppColors.gray50Color,
                          size: const Size(150, 0),
                          textsize: 14.sp,
                          textFontFamily: FontFamilyText.sFProDisplaySemibold,
                          onPressed: () {
                            //Get.to(() => LocationScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'See people who have already liked you',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey800Color,
                        fontSize: 12.sp,
                        fontFamily: FontFamilyText.sFProDisplaySemibold,
                        // fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    FavoriteGridViewBuilderModule(),
                  ],
                ).commonSymmetricPadding(horizontal: 20),
              ),
      ),
      // bottomNavigationBar: const BottomNavigationBarModule(),
    );
  }
}
