import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/enums.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_modules/custom_appbar.dart';
import '../../constants/colors.dart';
import '../../constants/messages.dart';
import '../../controller/cms_screen_controller.dart';

class CmsScreen extends StatelessWidget {
  CmsScreen({Key? key}) : super(key: key);
  final cmsScreenController = Get.put(CmsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: cmsScreenController.cmsIdentify == CmsIdentify.communityGuideline
            ? AppMessages.communityGuideline
            : cmsScreenController.cmsIdentify == CmsIdentify.privacyPolicy
                ? AppMessages.privacyPolicy
                : AppMessages.termsOfUseHeader,
      ),

      body: Obx(
        () => cmsScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Text(
                  cmsScreenController.cmsData.value,
                ).commonSymmetricPadding(vertical: 15, horizontal: 10),
              ),
      ),
    );
  }
}
