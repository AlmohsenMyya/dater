import 'dart:convert';

ResendCodeModel resendCodeModelFromJson(String str) => ResendCodeModel.fromJson(json.decode(str));

String resendCodeModelToJson(ResendCodeModel data) => json.encode(data.toJson());

class ResendCodeModel {
  ResendCodeModel({
    required this.response,
    required this.msg,
    required this.verifyToken,
    required this.msgSent,
    required this.statusCode,
  });

  String response;
  String msg;
  String verifyToken;
  bool msgSent;
  int statusCode;

  factory ResendCodeModel.fromJson(Map<String, dynamic> json) => ResendCodeModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    verifyToken: json["verify_token"] ?? "",
    msgSent: json["msg_sent"] ?? false,
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "verify_token": verifyToken,
    "msg_sent": msgSent,
    "status_code": statusCode,
  };
}