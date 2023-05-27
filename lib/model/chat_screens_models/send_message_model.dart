import 'dart:convert';

MessageSendModel messageSendModelFromJson(String str) => MessageSendModel.fromJson(json.decode(str));

String messageSendModelToJson(MessageSendModel data) => json.encode(data.toJson());

class MessageSendModel {
  MessageSendModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory MessageSendModel.fromJson(Map<String, dynamic> json) => MessageSendModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "status_code": statusCode,
  };
}