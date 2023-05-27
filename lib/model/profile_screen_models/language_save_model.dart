import 'dart:convert';

LanguageSaveModel languageSaveModelFromJson(String str) => LanguageSaveModel.fromJson(json.decode(str));

String languageSaveModelToJson(LanguageSaveModel data) => json.encode(data.toJson());

class LanguageSaveModel {
  LanguageSaveModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory LanguageSaveModel.fromJson(Map<String, dynamic> json) => LanguageSaveModel(
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