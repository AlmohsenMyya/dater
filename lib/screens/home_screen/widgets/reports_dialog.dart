import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../model/profile_screen_models/report_model.dart';
import '../../../utils/style.dart';

class ReportsDialog extends GetView<HomeScreenController> {
  const ReportsDialog({
    required this.reportsList,
    super.key,
  });

  final List<ReportModel> reportsList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Report User',
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Is this person bothering you? Tell us what they did.",
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey500Color,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ).commonSymmetricPadding(horizontal: 3.w),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 30.h,
          width: 100.w,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Center(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.selectedReportIndex.value = index;
                            },
                            child: Text(
                              reportsList[index].name,
                              style: TextStyleConfig.textStyle(
                                fontFamily: FontFamilyText.sFProDisplayRegular,
                                textColor: index ==
                                        controller.selectedReportIndex.value
                                    ? AppColors.lightOrangeColor
                                    : AppColors.grey500Color,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ).commonSymmetricPadding(horizontal: 3.w),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1),
                    itemCount: reportsList.length),
              ),
              ButtonCustom(
                text: 'Confirm',
                size: const Size(22.0, 22.0),
                onPressed: () {
                  controller.reportUser(
                      profileId: controller.currentUserId.toString(),
                      reportReasonId: controller
                          .reportsList[controller.selectedReportIndex.value].id
                          .toString());
                },
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textFontFamily: FontFamilyText.sFProDisplayHeavy,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
