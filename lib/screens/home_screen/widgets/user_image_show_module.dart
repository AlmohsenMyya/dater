import 'package:dater/constants/app_images.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../model/home_screen_model/suggestions_model.dart';

// ignore: must_be_immutable
class UserImageShowModule extends StatelessWidget {
  List<UserImage> userImagesList;
  final int imageListIndex;
  final int imageShowIndex;

  UserImageShowModule(
      {Key? key,
      required this.imageListIndex,
      required this.imageShowIndex,
      required this.userImagesList})
      : super(key: key);

  // final screenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    // printAll('imageListIndex : ${imageListIndex.toString()}');
    // printAll('imageShowIndex : ${imageShowIndex.toString()}');
    // printAll('userImagesList : ${userImagesList}');

    return userImagesList.length > imageListIndex
        ? SizedBox(
            height: 56.h,
            width: Get.width,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                userImagesList[imageShowIndex].imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, obj, st) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppImages.swiper1Image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ).commonSymmetricPadding(vertical: 5)
        : Container();
  }
}
