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

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      resizeToAvoidBottomInset: false,
      appBar: const MainAppBar(),
      body: Obx(
        () => homeScreenController.isLoading.value
            ? const CustomLoader()
            : NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.atEdge == true &&
                      notification.metrics.pixels > 0.0) {
                    homeScreenController.isVisible.value = false;
                  } else {
                    homeScreenController.isVisible.value = true;
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
                            Obx(
                              () => homeScreenController.isLoading.value
                                  ? Container()
                                  : SwipeUserModule(),
                            ),

                            /// Star button - Super love button
                            homeScreenController.suggestionList.isEmpty
                                ? Container()
                                : Positioned(
                                    bottom: Get.height * 0.02,
                                    right: Get.height / 166,
                                    child: Obx(
                                      () => AnimatedOpacity(
                                        opacity:
                                            homeScreenController.isVisible.value
                                                ? 1.0
                                                : 0.0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                        child: GestureDetector(
                                          onTap: () {
                                            homeScreenController.cardController
                                                .next(
                                              swipeDirection: SwipeDirection.up,
                                            );
                                          },
                                          child: Icon(Icons.star_rounded,
                                              color: AppColors.lightOrangeColor,
                                              size: Get.height / 13.84),
                                        ),
                                        /*child: IconButton(
                                      onPressed: () {
                                        homeScreenController.cardController
                                            .next(
                                          swipeDirection: SwipeDirection.up,
                                        );
                                      },
                                      icon: const Icon(Icons.star_rounded,
                                          color: AppColors.lightOrangeColor,
                                          size: 60)
                                  ),*/
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ).commonSymmetricPadding(horizontal: 1, vertical: 0),
                ),
              ),
      ),
    );
  }
}
