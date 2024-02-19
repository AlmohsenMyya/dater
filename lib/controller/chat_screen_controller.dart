import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dater/controller/index_screen_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/api_url.dart';
import '../model/chat_screens_models/chat_list_model.dart';
import '../model/chat_screens_models/send_message_model.dart';
import '../model/home_screen_model/matches_model.dart';
import '../utils/preferences/user_preference.dart';

class ChatScreenController extends GetxController {
  MatchUserData personData = Get.arguments[0];

  // MatchPersonData? personData = MatchPersonData(id: "2");
  RxBool isLoading = false.obs;
  RxBool isSendLoading = false.obs;
  RxBool isSendsuccess = false.obs;
  RxInt successStatus = 0.obs;

  UserPreference userPreference = UserPreference();

  var isEmojiVisible = false.obs;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<ChatData> chatList = [];

  var dioRequest = dio.Dio();
  RxBool isTimerOn = true.obs;

  Future<void> unMatchuser() async {
    String url = ApiUrl.unMatchApi;
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      String userId = await userPreference.getStringFromPrefs(
          key: UserPreference.userIdKey);
      log('Client userId : ${personData.id}');
      log('My userId : $userId');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['client_id'] = personData.id;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('unmatch Value : $value');
        if (successStatus.value == 200) {
        Get.back();
        } else {
          log('getUserChatMessagesFunction Else');
        }
      });
    } catch (e) {
      log('getUserChatMessagesFunction Error :$e');
      rethrow;
    }
    loadUI();
  }

  /// Send Message
  Future<void> sendChatMessageFunction() async {
    isSendLoading(true);
    String massege = textEditingController.text.trim();
    textEditingController.clear();
    String url = ApiUrl.sendMessageApi;
    log('sendChatMessageFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);

      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        'recipient_id': personData.id,
        'text': massege
      });

      log('Send chat formData : ${formData.fields}');

      var response = await dioRequest.post(url, data: formData);
      log('sendChatMessageFunction Response : ${response.data}');

      MessageSendModel messageSendModel =
          MessageSendModel.fromJson(json.decode(response.data));
      successStatus.value = messageSendModel.statusCode;

      if (successStatus.value == 200) {
        Fluttertoast.showToast(msg: messageSendModel.msg);

        chatList.add(ChatData(
            messageText: massege,
            clientMessage: true));

        await  getUserChatMessagesFunctionWithoutLoading();
      } else {
        Fluttertoast.showToast(msg: messageSendModel.msg);
        log('sendChatMessageFunction Else');
      }

      /*var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['recipient_id'] = personData.id;
      request.fields['text'] = textEditingController.text.trim().toString();

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('sendChatMessageFunction Value : $value');
        MessageSendModel messageSendModel = MessageSendModel.fromJson(json.decode(value));
        successStatus.value = messageSendModel.statusCode;

        if(successStatus.value == 200) {
          // Fluttertoast.showToast(msg: messageSendModel.msg);
          chatList.add(ChatData(messageText: textEditingController.text.trim(), clientMessage: true));
          textEditingController.clear();
        } else {
          log('sendChatMessageFunction Else');
        }

      });*/
    } catch (e) {
      Fluttertoast.showToast(msg:e.toString());
      log('sendChatMessageFunction Error :$e');
      rethrow;
    }

    isSendLoading(false);
  }

  /// Continuously call the api
  Future<void> getUserChatMessagesFunction() async {
    isLoading(true);

    String url = ApiUrl.getChatListApi;
    log('getUserChatMessagesFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      String userId = await userPreference.getStringFromPrefs(
          key: UserPreference.userIdKey);
      log('Client userId : ${personData.id}');
      log('My userId : $userId');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['sender_id'] = personData.id;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getUserChatMessagesFunction Value : $value');

        MessageListModel messageListModel =
            MessageListModel.fromJson(json.decode(value));
        successStatus.value = messageListModel.statusCode;

        if (successStatus.value == 200) {
          List<ChatData> newMessages = messageListModel.msg.reversed.toList();

          // Check for new messages and add them to the chatList
          for (var newMessage in newMessages) {
            checkForNewMessages(newMessage);
          }

          log('chatList Length ///////: ${chatList.length}');
        } else {
          log('getUserChatMessagesFunction Else');
        }
      });
    } catch (e) {
      log('getUserChatMessagesFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  /// Continuously call the api
  Future<void> getUserChatMessagesFunctionWithoutLoading() async {


    String url = ApiUrl.getChatListApi;
    log('getUserChatMessagesFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      String userId = await userPreference.getStringFromPrefs(
          key: UserPreference.userIdKey);
      log('Client userId : ${personData.id}');
      log('My userId : $userId');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['sender_id'] = personData.id;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getUserChatMessagesFunction Value : $value');

        MessageListModel messageListModel =
        MessageListModel.fromJson(json.decode(value));
        successStatus.value = messageListModel.statusCode;

        if (successStatus.value == 200) {
          List<ChatData> newMessages = messageListModel.msg.reversed.toList();

          // Check for new messages and add them to the chatList
          for (var newMessage in newMessages) {
            checkForNewMessages(newMessage);
          }

          log('chatList Length : ${chatList.length}');
        } else {
          log('getUserChatMessagesFunction Else');
        }
      });
    } catch (e) {
      log('getUserChatMessagesFunction Error :$e');
      rethrow;
    }
    isSendsuccess(true);
    isSendsuccess(false);
  }
  void checkForNewMessages(ChatData newMessage) {
    bool isNewMessage = chatList.every((existingMessage) =>
        existingMessage.messageText != newMessage.messageText);

    if (isNewMessage) {
      chatList.add(newMessage);
      Get.find<IndexScreenController>().newMessages.value = true;
      // isNewMessageIndicator.value = true;
    }
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }
  void handleMessageNotification(RemoteMessage message) async {
    debugPrint("onMessageOpenedApp almmmohsen handel : ${message.data}");
    await getUserChatMessagesFunctionWithoutLoading();
  }

  Future<void> initMethod() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage almmmohsen: ${message.data}");
      handleMessageNotification(message);
      // ... other code ...
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isEmojiVisible.value = false;
      }
    });
    await getUserChatMessagesFunction();
    // Timer.periodic(const Duration(seconds: 10), (timer) async {
    //   isTimerOn.value ? {await getUserChatMessagesFunction()} : null;
    // });
    // Timer.periodic(const Duration(seconds: 10), (timer) async {
    //   await getUserChatMessagesFunction();
    // });
  }

  /*@override
  void onClose() {
    super.onClose();
    textEditingController.selection;

  }*/

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

  @override
  void dispose() {
    super.dispose();
    isTimerOn.value = false;
    log('dispose isTimerOn : $isTimerOn');
    // Timer(const Duration(milliseconds: 100), () {}).cancel();
  }

// @override
// // TODO: implement onDelete
// InternalFinalCallback<void> get onDelete => deleteControllerFunction();
//
// deleteControllerFunction(){
//   super.onDelete;
//   Timer(const Duration(seconds: 1), () {}).cancel();
// }

  /// Get All Chats Function
// Future<void> getUserAllChatList() async {
//   // isLoading(true);
//   String url = ApiUrl.getChatListApi;
//   log('getUserAllChatList Api Url : $url');
//
//   try {
//     String verifyToken = await userPreference.getStringFromPrefs(
//         key: UserPreference.userVerifyTokenKey);
//     String userId = await userPreference.getStringFromPrefs(
//         key: UserPreference.userIdKey);
//     log('Client userId : ${personData.id}');
//     log('My userId : $userId');
//
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//
//     request.fields['token'] = verifyToken;
//     request.fields['sender_id'] = personData.id;
//
//     var response = await request.send();
//
//     response.stream.transform(utf8.decoder).listen((value) async {
//       log('getChatListFunction Value : $value');
//
//       MessageListModel messageListModel =
//       MessageListModel.fromJson(json.decode(value));
//       successStatus.value = messageListModel.statusCode;
//
//       if (successStatus.value == 200) {
//         List<ChatData> newMessages = messageListModel.msg.reversed.toList();
//
//         // Check for new messages and add them to the chatList
//         for (var newMessage in newMessages) {
//           checkForNewMessages(newMessage);
//         }
//         // chatList.addAll(messageListModel.msg);
//         log('chatList Length : ${chatList.length}');
//       } else {
//         log('sendChatMessageFunction Else');
//       }
//     });
//   } catch (e) {
//     log('getUserAllChatList Error :$e');
//     rethrow;
//   }
//   // isLoading(false);
// }
}
