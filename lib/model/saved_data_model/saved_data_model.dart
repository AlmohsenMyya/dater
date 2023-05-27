import 'dart:convert';

SavedDataModel savedDataModelFromJson(String str) => SavedDataModel.fromJson(json.decode(str));

String savedDataModelToJson(SavedDataModel data) => json.encode(data.toJson());

class SavedDataModel {
  SavedDataModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory SavedDataModel.fromJson(Map<String, dynamic> json) => SavedDataModel(
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