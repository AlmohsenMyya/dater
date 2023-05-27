import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String response;
  List<CountryData> msg;
  int statusCode;

  CountryModel({
   required this.response,
   required this.msg,
   required this.statusCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    response: json["response"] ?? "",
    msg: List<CountryData>.from((json["msg"] ?? []).map((x) => CountryData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class CountryData {
  String? id;
  String? name;
  bool? isSelected;

  CountryData({
    this.id,
    this.name,
    this.isSelected,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
      isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
