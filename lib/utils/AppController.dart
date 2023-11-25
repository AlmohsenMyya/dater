import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppController extends GetxController {
  var connectionStatus = 0.obs;
  late StreamSubscription<InternetConnectionStatus> _listener;

  void initInternetConnectionListener() {
    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;
          connectionStatus.refresh();
          break;
        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;
          connectionStatus.refresh();
          break;
      }
    });
  }

  @override
  void onInit() {
    initInternetConnectionListener();
    super.onInit();
  }

  @override
  void refresh() {
    initInternetConnectionListener();
    super.refresh();
  }
  @override
  void onClose() {
    _listener.cancel();
  }
}
