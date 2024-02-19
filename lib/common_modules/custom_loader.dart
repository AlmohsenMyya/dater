import 'package:dater/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  final double size;

  const CustomLoader({Key? key, this.size = -1.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loaderSize = size != -1.0 ? size : Get.height * 0.07;

    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.lightOrangeColor,
        size: loaderSize,
      ),
    );
  }
}

