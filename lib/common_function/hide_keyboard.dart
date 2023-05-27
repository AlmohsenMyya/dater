import 'package:flutter/material.dart';

void hideKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
