import 'dart:convert';

ReligionModel religionModelFromJson(String str) => ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  ReligionModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<ReligionData> msg;
  int statusCode;

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
    response: json["response"] ?? "",
    msg: List<ReligionData>.from((json["msg"] ?? []).map((x) => ReligionData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class ReligionData {
  ReligionData({
    this.name,
    this.isSelected,
  });

  String? name;
  bool? isSelected;

  factory ReligionData.fromJson(Map<String, dynamic> json) => ReligionData(
    name: json["name"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
