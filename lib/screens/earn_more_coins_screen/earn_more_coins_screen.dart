import 'package:dater/constants/colors.dart';
import 'package:dater/constants/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_modules/custom_appbar.dart';
import '../../controller/earn_more_coins_screen_controller.dart';
import 'earn_more_coins_screen_widgets.dart';

class EarnMoreCoinsScreen extends StatelessWidget {
   EarnMoreCoinsScreen({Key? key}) : super(key: key);
final earnMoreCoinsScreenController = Get.put(EarnMoreCoinsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.earnMoreCoins),
      body: SafeArea(
        child: Column(
          children: [
            EarnMoreCoinsWidgetModule(),
          ],
        ),
      ),
    );
  }
}
