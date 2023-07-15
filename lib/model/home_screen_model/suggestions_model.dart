/*
import 'dart:convert';

SuggestionListModel suggestionListModelFromJson(String str) => SuggestionListModel.fromJson(json.decode(str));

String suggestionListModelToJson(SuggestionListModel data) => json.encode(data.toJson());

class SuggestionListModel {
  SuggestionListModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<SuggestionData> msg;
  int statusCode;

  factory SuggestionListModel.fromJson(Map<String, dynamic> json) => SuggestionListModel(
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
    this.id,
    this.name,
    this.sexualityGet,
    this.targetGenderGet,
    this.profilePrompts,
    this.bio,
    this.homeTown,
    this.languages,
    this.verified,
    this.distance,
    this.age,
    this.activeTime,
    this.interest,
    this.basic,
  });

  String? id;
  String? name;
  String? sexualityGet;
  String? targetGenderGet;
  String? profilePrompts;
  String? bio;
  String? homeTown;
  String? languages;
  String? verified;
  String? distance;
  String? age;
  String? activeTime;
  List<Interest>? interest;
  Basic? basic;

  factory SuggestionData.fromJson(Map<String, dynamic> json) => SuggestionData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    sexualityGet: json["sexuality_get"] ?? "",
    targetGenderGet: json["target_gender_get"] ?? "",
    profilePrompts: json["profile_prompts"] ?? "",
    bio: json["bio"] ?? "",
    homeTown: json["home_town"] ?? "",
    languages: json["languages"] ?? "",
    verified: json["verified"] ?? "",
    distance: json["distance"] ?? "",
    age: json["age"] ?? "",
    activeTime: json["active_time"] ?? "",
    interest: List<Interest>.from((json["interest"] ?? []).map((x) => x ?? {})),
    basic: Basic.fromJson(json["basic"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sexuality_get": sexualityGet,
    "target_gender_get": targetGenderGet,
    "profile_prompts": profilePrompts,
    "bio": bio,
    "home_town": homeTown,
    "languages": languages,
    "verified": verified,
    "distance": distance,
    "age": age,
    "active_time": activeTime,
    "interest": List<dynamic>.from(interest!.map((x) => x)),
    "basic": basic!.toJson(),
  };
}


class Basic {
  Basic({
    required this.gender,
    required this.work,
    required this.education,
    required this.height,
    required this.exercise,
    required this.smoking,
    required this.drinking,
    required this.politics,
    required this.religion,
    required this.kids,
  });

  String gender;
  String work;
  String education;
  String height;
  String exercise;
  String smoking;
  String drinking;
  String politics;
  String religion;
  String kids;

  factory Basic.fromJson(Map<String, dynamic> json) => Basic(
    gender: json["gender"] ?? "",
    work: json["work"] ?? "",
    education: json["education"] ?? "",
    height: json["height"] ?? "",
    exercise: json["exercise"] ?? "",
    smoking: json["smoking"] ?? "",
    drinking: json["drinking"] ?? "",
    politics: json["politics"] ?? "",
    religion: json["religion"] ?? "",
    kids: json["kids"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "work": work,
    "education": education,
    "height": height,
    "exercise": exercise,
    "smoking": smoking,
    "drinking": drinking,
    "politics": politics,
    "religion": religion,
    "kids": kids,
  };
}


class Interest {
  Interest({
    required this.name,
  });

  String name;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
*/

import 'dart:convert';

import '../../constants/app_images.dart';

SuggestionListModel suggestionListModelFromJson(String str) =>
    SuggestionListModel.fromJson(json.decode(str));

String suggestionListModelToJson(SuggestionListModel data) =>
    json.encode(data.toJson());

class SuggestionListModel {
  SuggestionListModel({
    required this.response,
    required this.msg,
    required this.statusCode,
  });

  String response;
  List<SuggestionData> msg;
  int statusCode;

  factory SuggestionListModel.fromJson(Map<String, dynamic> json) =>
      SuggestionListModel(
        response: json["response"] ?? "",
        msg: List<SuggestionData>.from(
            (json["msg"] ?? []).map((x) => SuggestionData.fromJson(x ?? {}))),
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
    this.id,
    this.name,
    this.sexualityGet,
    this.targetGenderGet,
    this.prompts,
    // this.profilePrompts,
    this.bio,
    this.homeTown,
    this.languages,
    this.verified,
    this.distance,
    this.age,
    this.activeTime,
    this.interest,
    this.basic,
    this.images,
    this.starSign,
    this.country,
    this.percentage,
  });

  String? id;
  String? name;
  String? sexualityGet;
  String? targetGenderGet;

  // String? profilePrompts;
  List<Prompt>? prompts;
  String? bio;
  String? homeTown;
  List<String>? languages;
  String? verified;
  String? distance;
  String? age;
  String? starSign;
  String? activeTime;
  List<Interest>? interest;
  Basic? basic;
  List<UserImage>? images;
  int? percentage;
  String? country;

  factory SuggestionData.fromJson(Map<String, dynamic> json) => SuggestionData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        sexualityGet: json["sexuality_get"] ?? "",
        targetGenderGet: json["target_gender_get"] ?? "",
        prompts: List<Prompt>.from(
            (json["prompts"] ?? []).map((x) => Prompt.fromJson(x))),
        // profilePrompts: json["profile_prompts"] ?? "Life is simple Don't overthink it",
        bio: json["bio"] ?? "",
        starSign: json['star_sign'],
        homeTown: json["home_town"] ?? "",
        languages: json["languages"] == null
            ? []
            : List<String>.from((json["languages"] ?? []).map((x) => x ?? "")),
        verified: json["verified"] ?? "",
        distance: (json["distance"] ?? 0).toString(),
        age: json["age"].toString().toLowerCase() ==
                    "Age is not available".toLowerCase() ||
                json["age"] == null
            ? ""
            : json["age"].toString(),
        activeTime: json["active_time"] ?? "",
        interest: List<Interest>.from(
            (json["interest"] ?? []).map((x) => Interest.fromJson(x ?? {}))),
        basic: Basic.fromJson(json["basic"] ?? {}),
        images: json["images"] == null
            ? []
            : List<UserImage>.from(
                (json["images"] ?? []).map((x) => UserImage.fromJson(x ?? {}))),
        percentage: json["percentage"] ?? 0,
        country: json["country"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sexuality_get": sexualityGet,
        "target_gender_get": targetGenderGet,
        "star_sign": starSign,
        // "profile_prompts": profilePrompts,
        "bio": bio,
        "home_town": homeTown,
        "languages": languages,
        "verified": verified,
        "distance": distance,
        "age": age,
        "active_time": activeTime,
        "interest": List<Interest>.from(interest!.map((x) => x)),
        "basic": basic!.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Prompt {
  String question;
  String promptId;
  String answer;

  Prompt({
    required this.question,
    required this.promptId,
    required this.answer,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
        question: json["question"] ?? "",
        promptId: json["prompt_id"] ?? "",
        answer: json["answer"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "prompt_id": promptId,
        "answer": answer,
      };
}

class UserImage {
  String id;
  String imageUrl;

  UserImage({
    required this.id,
    required this.imageUrl,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        id: json["id"] ?? "",
        imageUrl: json["image_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}

class Basic {
  Basic({
    required this.gender,
    required this.work,
    required this.education,
    required this.height,
    required this.exercise,
    required this.smoking,
    required this.drinking,
    required this.politics,
    required this.religion,
    required this.kids,
  });

  String gender;
  String work;
  String education;
  String height;
  String exercise;
  String smoking;
  String drinking;
  String politics;
  String religion;
  String kids;

  factory Basic.fromJson(Map<String, dynamic> json) => Basic(
        gender: json["gender"] ?? "",
        work: json["work"] ?? "",
        education: json["education"] ?? "",
        height: json["height"] ?? "",
        exercise: json["exercise"] ?? "",
        smoking: json["smoking"] ?? "",
        drinking: json["drinking"] ?? "",
        politics: json["politics"] ?? "",
        religion: json["religion"] ?? "",
        kids: json["kids"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "work": work,
        "education": education,
        "height": height,
        "exercise": exercise,
        "smoking": smoking,
        "drinking": drinking,
        "politics": politics,
        "religion": religion,
        "kids": kids,
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
        image: json["image"] ?? AppImages.ballImage,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
