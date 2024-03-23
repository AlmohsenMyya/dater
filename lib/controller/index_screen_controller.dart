import 'package:dater/controller/balance_screen_controller.dart';
import 'package:dater/controller/chat_screen_controller.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:get/get.dart';

import '../utils/preferences/user_preference.dart';
import 'all_chat_list_screen_controller.dart';

class IndexScreenController extends GetxController {
  var selectedIndex = 1.obs;

  final RxBool newMessages = false.obs;
  UserPreference userPreference = UserPreference();

  @override
  void onInit() async {
    BalanceScreenController balanceScreenController =
    Get.put(BalanceScreenController());
    String isFirstTime = await userPreference.getStringFromPrefs(
        key: UserPreference.isYourFirtsTime);
    if (isFirstTime == "yes"){
    balanceScreenController.setFCMTokenFunc();

    }
    // Initialization tasks can be performed here
    super.onInit();
  }

  // RxBool homeScreenShow = true.obs;
  changeIndex(int index) async {
    selectedIndex.value = index;
    if (index == 0) {
      BalanceScreenController balanceScreenController =
          Get.find<BalanceScreenController>();
      balanceScreenController.getMyCoinsFunction();
    } else if (index == 2) {
      AllChatListScreenController chatScreenController =
          Get.put(AllChatListScreenController());
      newMessages.value=false;
      await chatScreenController.initMethod();
    }
  }
}


