import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/screens/home_screen/widgets/main_app_bar.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

import 'home_screen_widgets.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({Key? key}) : super(key: key);

  // final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor2,
        resizeToAvoidBottomInset: false,
        appBar:  MainAppBar(),
        body: Obx(
          () => controller.isLoading.value
              ? const CustomLoader()
              : NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.atEdge == true &&
                        notification.metrics.pixels > 0.0) {
                      controller.isVisible.value = false;
                    } else {
                      controller.isVisible.value = true;
                    }
                    return false;
                  },
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SwipeUserModule(),

                              /// Star button - Super love button
                              Positioned(
                                bottom: Get.height * 0.03,
                                right: Get.height / 166,
                                child: Obx(
                                  () => AnimatedOpacity(
                                    opacity:
                                        controller.isVisible.value ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate,
                                    child: Visibility(
                                      visible: controller.isVisible.value,
                                      child: GestureDetector(
                                        onTap: () {
                                          printAll('float');
                                          controller.cardController.value.next(
                                            swipeDirection: SwipeDirection.up,
                                          );
                                        },
                                        child: Icon(Icons.star_rounded,
                                            color: AppColors.lightOrangeColor,
                                            size: Get.height / 13.84),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).commonSymmetricPadding(horizontal: 8, vertical: 0),
                  ),
                ),
        ));
  }
}
