import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/controller/balance_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'balance_screen_widgets.dart';

class BalanceScreen extends StatelessWidget {
  BalanceScreen({super.key});
  final balanceScreenController = Get.put(BalanceScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      body: Obx(
        ()=> balanceScreenController.isLoading.value
        ? const CustomLoader()
        : SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                WidgetsBalanceModule(),
              ],
            ).commonOnlyPadding(top: 10, bottom: 10, left: 15, right: 15),
          ),
        ),
      ),
      //  bottomNavigationBar:  BottomNavigationBarModule(),
    );
  }
}
