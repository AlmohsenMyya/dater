import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationPermissionController extends GetxController {
  getPermission() async {
    Location location = Location();

    bool _serviceEnabled;
    _serviceEnabled = await location.requestService();
    log("_serviceEnabled :$_serviceEnabled");
    if (_serviceEnabled == true) {
      Get.back();
    }
  }
}
