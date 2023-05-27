import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../constants/messages.dart';
import '../model/chat_screens_models/chat_list_model.dart';
import '../model/chat_screens_models/send_message_model.dart';
import '../model/home_screen_model/matches_model.dart';
import '../utils/preferences/user_preference.dart';
import 'package:dio/dio.dart' as dio;

class ChatScreenController extends GetxController {
  MatchUserData personData = Get.arguments[0];
  // MatchPersonData? personData = MatchPersonData(id: "2");
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  UserPreference userPreference = UserPreference();

  var isEmojiVisible = false.obs;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<ChatData> chatList = [];

  var dioRequest = dio.Dio();
  RxBool isTimerOn = true.obs;


  /// Get All Chats Function
  Future<void> getUserAllChatList() async {
    isLoading(true);
    String url = ApiUrl.getChatListApi;
    log('getUserAllChatList Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      String userId = await userPreference.getStringFromPrefs(key: UserPreference.userIdKey);
      log('Client userId : ${personData.id}');
      log('My userId : $userId');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['sender_id'] = personData.id;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getChatListFunction Value : $value');

        MessageListModel messageListModel = MessageListModel.fromJson(json.decode(value));
        successStatus.value = messageListModel.statusCode;

        if(successStatus.value == 200) {
          chatList.clear();
          chatList.addAll(messageListModel.msg.reversed);
          // chatList.addAll(messageListModel.msg);
          log('chatList Length : ${chatList.length}');
        } else {
          log('sendChatMessageFunction Else');
        }
      });
    } catch(e) {
      log('getUserAllChatList Error :$e');
      rethrow;
    }
    isLoading(false);
  }


  /// Send Message
  Future<void> sendChatMessageFunction() async {
    String url = ApiUrl.sendMessageApi;
    log('sendChatMessageFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);

      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        'recipient_id': personData.id,
        'text': textEditingController.text.trim().toString()
      });

      log('Send chat formData : ${formData.fields}');


      var response = await dioRequest.post(url, data: formData);
      log('sendChatMessageFunction Response : ${response.data}');

      MessageSendModel messageSendModel = MessageSendModel.fromJson(json.decode(response.data));
      successStatus.value = messageSendModel.statusCode;

      if(successStatus.value == 200) {
        // Fluttertoast.showToast(msg: messageSendModel.msg);
        chatList.add(ChatData(messageText: textEditingController.text.trim(), clientMessage: true));
        textEditingController.clear();
      } else {
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

    } catch(e) {
      log('sendChatMessageFunction Error :$e');
      rethrow;
    }
    loadUI();
  }


  /// Continuously call the api
  Future<void> getUserChatMessagesFunction() async {
    String url = ApiUrl.getChatListApi;
    log('getUserChatMessagesFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      String userId = await userPreference.getStringFromPrefs(key: UserPreference.userIdKey);
      log('Client userId : ${personData.id}');
      log('My userId : $userId');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['sender_id'] = personData.id;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getUserChatMessagesFunction Value : $value');

        MessageListModel messageListModel = MessageListModel.fromJson(json.decode(value));
        successStatus.value = messageListModel.statusCode;

        if(successStatus.value == 200) {
          chatList.clear();
          chatList.addAll(messageListModel.msg.reversed);
          // chatList.addAll(messageListModel.msg);
          log('chatList Length : ${chatList.length}');
        } else {
          log('getUserChatMessagesFunction Else');
        }
      });
    } catch(e) {
      log('getUserChatMessagesFunction Error :$e');
      rethrow;
    }
    loadUI();
  }



  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        isEmojiVisible.value = false;
      }
    });

    await getUserAllChatList();

    // isTimerOn.value
    //     ?
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      isTimerOn.value ? await getUserChatMessagesFunction() : null;
          });
        // : () {};
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

}