import 'dart:convert';

CountryListModel countryListModelFromJson(String str) => CountryListModel.fromJson(json.decode(str));

String countryListModelToJson(CountryListModel data) => json.encode(data.toJson());

class CountryListModel {
  CountryListModel({
    required this.countryList,
  });

  List<CountryData> countryList;

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    countryList: List<CountryData>.from((json["countryList"] ?? []).map((x) => CountryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countryList": List<dynamic>.from(countryList.map((x) => x.toJson())),
  };
}

class CountryData {
  CountryData({
    this.name,
    this.dialCode,
    this.emoji,
    this.code,
  });

  String? name;
  String? dialCode;
  String? emoji;
  String? code;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    name: json["name"] ?? "",
    dialCode: json["dial_code"] ?? "",
    emoji: json["emoji"] ?? "",
    code: json["code"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dial_code": dialCode,
    "emoji": emoji,
    "code": code,
  };
}
