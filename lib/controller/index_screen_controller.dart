import 'package:dater/controller/balance_screen_controller.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:get/get.dart';

import 'all_chat_list_screen_controller.dart';

class IndexScreenController extends GetxController {
  var selectedIndex = 1.obs;

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
      await chatScreenController.initMethod();
    }
  }
}

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IndexScreenController());
    Get.put(HomeScreenController());
  }
}
