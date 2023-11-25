import 'dart:developer';

import 'package:dater/constants/colors.dart';
import 'package:dater/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'AppController.dart';

class NetworkStatusService extends GetxService {
  NetworkStatusService() {
    InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          log('internet restored');
          // connectionStatus.value = 1;
          // connectionStatus.refresh();
          break;
        case InternetConnectionStatus.disconnected:
          log('internet lost');
          Get.dialog(barrierDismissible: true, showNoInternetDialog());
          break;
      }
    });
  }
}

showNoInternetDialog() async {
  AppController controller = Get.find<AppController>();
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: Colors.transparent,
          height: Get.height,
          width: Get.width,
          child: AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection and try again.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Retry',
                  style: TextStyle(
                    color: AppColors.darkOrangeColor
                  ),
                ),
                onPressed: () {
                  if (controller.connectionStatus.value == 1) {
                    controller.refresh();
                    closePopUp();
                  } else {
                    ScaffoldMessenger.of(Get.context!).showSnackBar(
                      SnackBar(
                        content: Text('no internet connection'.tr),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
