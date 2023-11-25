import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/controller/index_screen_controller.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IndexScreenController());
    Get.put(HomeScreenController());
  }
}
