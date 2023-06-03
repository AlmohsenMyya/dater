/// New Model - Update User Location Model - api/update_location
import 'dart:convert';

import 'constants/app_images.dart';

UpdateLocationModel updateLocationModelFromJson(String str) => UpdateLocationModel.fromJson(json.decode(str));

String updateLocationModelToJson(UpdateLocationModel data) => json.encode(data.toJson());

class UpdateLocationModel {
  UpdateLocationModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  String msg;
  String token;
  int statusCode;

  factory UpdateLocationModel.fromJson(Map<String, dynamic> json) => UpdateLocationModel(
    response: json["response"] ?? "",
    msg: json["msg"] ?? "",
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "token": token,
    "status_code": statusCode,
  };
}



/// New model - User Get Age Model - api/get_birth_year

UserAgeModel userAgeModelFromJson(String str) => UserAgeModel.fromJson(json.decode(str));

String userAgeModelToJson(UserAgeModel data) => json.encode(data.toJson());

class UserAgeModel {
  UserAgeModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  String msg;
  int statusCode;

  factory UserAgeModel.fromJson(Map<String, dynamic> json) => UserAgeModel(
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



/// New Model - Suggestions Model - api/suggestions

SuggestionsModel suggestionsModelFromJson(String str) => SuggestionsModel.fromJson(json.decode(str));

String suggestionsModelToJson(SuggestionsModel data) => json.encode(data.toJson());

class SuggestionsModel {
  SuggestionsModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<SuggestionData> msg;
  int statusCode;

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) => SuggestionsModel(
    response: json["response"] ?? "",
    msg: List<SuggestionData>.from((json["msg"] ?? []).map((x) => SuggestionData.fromJson(x ?? {}))),
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "status_code": statusCode,
  };
}

class SuggestionData {
  SuggestionData({
    required this.id,
    required this.name,
    required this.genderGet,
    required this.sexualityGet,
    required this.targetGenderGet,
    required this.profilePrompts,
    required this.bio,
    required this.work,
    required this.education,
    required this.homeTown,
    required this.height,
    required this.exercise,
    required this.smoking,
    required this.drinking,
    required this.kids,
    required this.politics,
    required this.religion,
    required this.verified,
    required this.distance,
    required this.age,
    required this.activeTime,
    required this.interest,
  });

  String id;
  String name;
  String genderGet;
  String sexualityGet;
  String targetGenderGet;
  String profilePrompts;
  String bio;
  String work;
  String education;
  String homeTown;
  String height;
  String exercise;
  String smoking;
  String drinking;
  String kids;
  String politics;
  String religion;
  String verified;
  String distance;
  String age;
  String activeTime;
  List<Interest> interest;

  factory SuggestionData.fromJson(Map<String, dynamic> json) => SuggestionData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    genderGet: json["gender_get"] ?? "",
    sexualityGet: json["sexuality_get"] ?? "",
    targetGenderGet: json["target_gender_get"] ?? "",
    profilePrompts: json["profile_prompts"] ?? "",
    bio: json["bio"] ?? "",
    work: json["work"] ?? "",
    education: json["education"] ?? "",
    homeTown: json["home_town"] ?? "",
    height: json["height"] ?? "",
    exercise: json["exercise"] ?? "",
    smoking: json["smoking"] ?? "",
    drinking: json["drinking"] ?? "",
    kids: json["kids"] ?? "",
    politics: json["politics"] ?? "",
    religion: json["religion"] ?? "",
    verified: json["verified"] ?? "",
    distance: json["distance"] ?? "",
    age: json["age"] ?? "",
    activeTime: json["active_time"] ?? "",
    interest: List<Interest>.from((json["interest"] ?? []).map((x) => x ?? {})),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender_get": genderGet,
    "sexuality_get": sexualityGet,
    "target_gender_get": targetGenderGet,
    "profile_prompts": profilePrompts,
    "bio": bio,
    "work": work,
    "education": education,
    "home_town": homeTown,
    "height": height,
    "exercise": exercise,
    "smoking": smoking,
    "drinking": drinking,
    "kids": kids,
    "politics": politics,
    "religion": religion,
    "verified": verified,
    "distance": distance,
    "age": age,
    "active_time": activeTime,
    "interest": List<dynamic>.from(interest.map((x) => x)),
  };
}

class Interest {
  Interest({
    required this.name,
    required this.image,
  });
  String name;
  String image;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    name: json["name"] ?? "",
    image: json["image"]??AppImages.ballImage,

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image":image,
  };
}
