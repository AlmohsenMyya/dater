import 'dart:convert';

StarSignModel starSignModelFromJson(String str) => StarSignModel.fromJson(json.decode(str));

String starSignModelToJson(StarSignModel data) => json.encode(data.toJson());

class StarSignModel {
  StarSignModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<StarSignData> msg;
  int statusCode;

  factory StarSignModel.fromJson(Map<String, dynamic> json) => StarSignModel(
    response: json["response"] ?? "",
    msg: List<StarSignData>.from((json["msg"] ?? []).map((x) => StarSignData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class StarSignData {
  StarSignData({
    this.name,
    this.isSelected,
  });

  String? name;
  bool? isSelected;

  factory StarSignData.fromJson(Map<String, dynamic> json) => StarSignData(
    name: json["name"] ?? "",
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,

  };
}
