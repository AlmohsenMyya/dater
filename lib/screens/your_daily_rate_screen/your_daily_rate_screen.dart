import 'package:dater/controller/your_daily_rate_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_modules/custom_appbar.dart';
import '../../constants/colors.dart';
import '../../constants/messages.dart';

class YourDailyRateScreen extends StatelessWidget {
   YourDailyRateScreen({Key? key}) : super(key: key);
final yourDailyRateScreenController = Get.put(YourDailyRateScreenController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.yourDailyRate),
    );
  }
}
