import 'package:dater/controller/balance_screen_controller.dart';
import 'package:dater/controller/profile_screen_controller.dart';
import 'package:get/get.dart';

class IndexScreenController extends GetxController {
  var selectedIndex = 1.obs;

  // RxBool homeScreenShow = true.obs;
  changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      BalanceScreenController balanceScreenController =
          Get.find<BalanceScreenController>();
      balanceScreenController.getMyCoinsFunction();
    } else if (index == 3) {
      final profileScreenController = Get.find<ProfileScreenController>();
      profileScreenController.getUserDetailsFunction();
    }
  }
}
