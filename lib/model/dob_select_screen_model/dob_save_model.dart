import 'dart:convert';

DobSaveModel dobSaveModelFromJson(String str) => DobSaveModel.fromJson(json.decode(str));

String dobSaveModelToJson(DobSaveModel data) => json.encode(data.toJson());

class DobSaveModel {
  DobSaveModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  String msg;
  String token;
  int statusCode;

  factory DobSaveModel.fromJson(Map<String, dynamic> json) => DobSaveModel(
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