import 'dart:convert';

SaveStarSignModel saveStarSignModelFromJson(String str) => SaveStarSignModel.fromJson(json.decode(str));

String saveStarSignModelToJson(SaveStarSignModel data) => json.encode(data.toJson());

class SaveStarSignModel {
  SaveStarSignModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory SaveStarSignModel.fromJson(Map<String, dynamic> json) => SaveStarSignModel(
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
