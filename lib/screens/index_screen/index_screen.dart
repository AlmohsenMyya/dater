import 'package:dater/controller/index_screen_controller.dart';
import 'package:dater/screens/balance_screen/balance_screen.dart';
import 'package:dater/screens/chat_screen/chat_list_screen/all_chat_list_screen.dart';
import 'package:dater/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_images.dart';
import '../../constants/colors.dart';
import '../profile_screen/profile_screen.dart';

class IndexScreen extends GetView<IndexScreenController> {
  IndexScreen({Key? key}) : super(key: key);

  // final indexScreenController = Get.put(IndexScreenController());
  final screen = [
    BalanceScreen(),
    HomeScreen(),
    AllChatListScreen(),
    ProfileScreen(),
  ];

  /*Future<bool> willPopCallback() async {
    if (indexScreenController.homeScreenShow.value == false) {
      indexScreenController.homeScreenShow.value = true;
      return false;
    } else {
      return true;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: screen,
        ),
      ),

      //  Obx(
      //   () => IndexedStack(
      //     index: indexScreenController.selectedIndex.value,
      //     children: screen,
      //   ),
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.gray50Color,
          unselectedItemColor: AppColors.blackColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) async {
            // indexScreenController.homeScreenShow.value = false;
            await controller.changeIndex(index);
          },
          currentIndex: controller.selectedIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.balanceImage,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.favoriteImage,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.messageImage,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.personImage,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
