import 'package:dater/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.lightOrangeColor,
        size: Get.height * 0.07,
      ),
    );
    /*return const Center(
      child: CircularProgressIndicator(
        color: AppColors.darkOrangeColor,
      ),
    );*/
  }
}
