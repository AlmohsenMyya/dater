import 'dart:convert';

DeleteImageModel deleteImageModelFromJson(String str) => DeleteImageModel.fromJson(json.decode(str));

String deleteImageModelToJson(DeleteImageModel data) => json.encode(data.toJson());

class DeleteImageModel {
  DeleteImageModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory DeleteImageModel.fromJson(Map<String, dynamic> json) => DeleteImageModel(
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