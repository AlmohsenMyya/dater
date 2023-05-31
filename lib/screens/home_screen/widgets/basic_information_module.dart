import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../controller/home_screen_controller.dart';
import '../../../model/profile_screen_models/basic_model.dart';

// ignore: must_be_immutable
class BasicInFormationModule extends StatelessWidget {
  List<BasicModel> basicList;

  BasicInFormationModule({super.key, required this.basicList});

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    // printAll("object ${homeScreenController.basicList.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppMessages.basics,
              style: TextStyleConfig.textStyle(
                fontSize: 16.sp,
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 0.0,
          children: List.generate(
            basicList.length,
            (int index) {
              return (basicList[index].name == '') ||
                      (basicList[index].name == ' cm')
                  ? const SizedBox()
                  : Transform(
                      transform: Matrix4.identity()..scale(0.93),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            basicList[index].image,
                          ),
                        ).commonOnlyPadding(left: 1),
                        label: Text(
                          basicList[index].name,
                          style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.sFProDisplaySemibold,
                            textColor: AppColors.grey600Color,
                            fontSize: 16,
                          ),
                        ),
                        selected: false,
                        selectedColor: AppColors.darkOrangeColor,
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColors.grey400Color,
                            width: 1.5,
                          ),
                        ),
                        onSelected: (bool value) {},
                      ),
                    );
            },
          ).toList(),
        )
      ],
    );
  }
}
