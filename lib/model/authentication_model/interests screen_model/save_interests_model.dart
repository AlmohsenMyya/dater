import 'dart:convert';

SaveInterestModel saveInterestModelFromJson(String str) => SaveInterestModel.fromJson(json.decode(str));

String saveInterestModelToJson(SaveInterestModel data) => json.encode(data.toJson());

class SaveInterestModel {
  SaveInterestModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  String msg;
  String token;
  int statusCode;

  factory SaveInterestModel.fromJson(Map<String, dynamic> json) => SaveInterestModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "token": token,
    "status_code": statusCode,
  };
}