import 'package:get/get.dart';

class WelcomePageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WelcomePageController());
  }
}
