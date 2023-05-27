import 'dart:convert';

PoliticsModel politicsModelFromJson(String str) => PoliticsModel.fromJson(json.decode(str));

String politicsModelToJson(PoliticsModel data) => json.encode(data.toJson());

class PoliticsModel {
  PoliticsModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<PoliticsData> msg;
  int statusCode;

  factory PoliticsModel.fromJson(Map<String, dynamic> json) => PoliticsModel(
    response: json["response"] ?? "",
    msg: List<PoliticsData>.from((json["msg"] ?? []).map((x) => PoliticsData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class PoliticsData {
  PoliticsData({
    this.name,
    this.isSelected,
  });

  String? name;
  bool? isSelected;

  factory PoliticsData.fromJson(Map<String, dynamic> json) => PoliticsData(
    name: json["name"] ?? "",
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
