import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) => json.encode(data.toJson());

class DeleteAccountModel {
  DeleteAccountModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
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