import 'dart:developer';

import 'package:get/get.dart';

void printAll(text, {name = 'log'}) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk

  pattern
      .allMatches('$text')
      .forEach((match) => log(name: name, match.group(0).toString()));
}

void closePopUp() {
  Get.back(closeOverlays: true, canPop: true);
}
