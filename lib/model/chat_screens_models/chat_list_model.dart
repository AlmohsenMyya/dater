import 'dart:convert';

MessageListModel messageListModelFromJson(String str) => MessageListModel.fromJson(json.decode(str));

String messageListModelToJson(MessageListModel data) => json.encode(data.toJson());

class MessageListModel {
  MessageListModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<ChatData> msg;
  int statusCode;

  factory MessageListModel.fromJson(Map<String, dynamic> json) => MessageListModel(
    response: json["response"] ?? "",
    msg: List<ChatData>.from((json["msg"] ?? []).map((x) => ChatData.fromJson(x ?? {}))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class ChatData {
  ChatData({
    required this.messageText,
    required this.clientMessage,
  });

  String messageText;
  bool clientMessage;

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
    messageText: json["message_text"] ?? "",
    clientMessage: json["client_message"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "message_text": messageText,
    "client_message": clientMessage,
  };
}