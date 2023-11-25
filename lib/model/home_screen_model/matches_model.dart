/*
import 'dart:convert';

MatchesModel matchesModelFromJson(String str) => MatchesModel.fromJson(json.decode(str));

String matchesModelToJson(MatchesModel data) => json.encode(data.toJson());

class MatchesModel {
  MatchesModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  List<MatchPersonData> msg;
  String token;
  int statusCode;

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
    response: json["response"] ?? "",
    msg: json["msg"].toString().toLowerCase() == "No data".toLowerCase()
        || json["msg"].toString().toLowerCase() == "Not valid or inactive client".toLowerCase()
        ? []
        : List<MatchPersonData>.from((json["msg"] ?? []).map((x) => MatchPersonData.fromJson(x ?? {}))),
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "token": token,
    "status_code": statusCode,
  };
}

class MatchPersonData {
  MatchPersonData({
    this.id,
    this.name,
    this.genderGet,
    this.yearOfBirth,
    this.latitude,
    this.longitude,
    this.profilePrompts,
    this.bio,
    this.work,
    this.education,
    this.uniid,
    this.genderGetId,
    this.distance,
  });

  String? id;
  String? name;
  String? genderGet;
  String? yearOfBirth;
  String? latitude;
  String? longitude;
  String? profilePrompts;
  String? bio;
  String? work;
  String? education;
  String? uniid;
  String? genderGetId;
  String? distance;

  factory MatchPersonData.fromJson(Map<String, dynamic> json) => MatchPersonData(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    genderGet: json["gender_get"] ?? "",
    yearOfBirth: json["year_of_birth"] ?? "",
    latitude: json["latitude"] ?? "",
    longitude: json["longitude"] ?? "",
    profilePrompts: json["profile_prompts"] ?? "",
    bio: json["bio"] ?? "",
    work: json["work"] ?? "",
    education: json["education"] ?? "",
    uniid: json["uniid"] ?? "",
    genderGetId: json["gender_get_id"] ?? "",
    distance: json["distance"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender_get": genderGet,
    "year_of_birth": yearOfBirth,
    "latitude": latitude,
    "longitude": longitude,
    "profile_prompts": profilePrompts,
    "bio": bio,
    "work": work,
    "education": education,
    "uniid": uniid,
    "gender_get_id": genderGetId,
    "distance": distance,
  };
}
*/

import 'dart:convert';

MatchesModel matchesModelFromJson(String str) =>
    MatchesModel.fromJson(json.decode(str));

String matchesModelToJson(MatchesModel data) => json.encode(data.toJson());

class MatchesModel {
  String response;
  List<MatchUserData> msg;
  String token;
  int statusCode;

  MatchesModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
        response: json["response"] ?? "",
        msg: json["msg"] == "No data"
            ? []
            : List<MatchUserData>.from((json["msg"] ?? [])
                .map((x) => MatchUserData.fromJson(x ?? {}))),
        token: json["token"] ?? "",
        statusCode: json["status_code"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
        "token": token,
        "status_code": statusCode,
      };
}

class MatchUserData {
  String id;
  String name;
  String bio;
  String verified;
  List<UserImage> images;
  String distance;
  int age;
  String activeTime;
  List<Interest> interest;

  // List<Prompt> prompts;
  int percentage;
  Basic basic;
  String languages;
  LastMessage lastMessage;

  MatchUserData({
    required this.id,
    required this.name,
    required this.bio,
    required this.verified,
    required this.images,
    required this.distance,
    required this.age,
    required this.activeTime,
    required this.interest,
    // required this.prompts,
    required this.percentage,
    required this.basic,
    required this.languages,
    required this.lastMessage,
  });

  factory MatchUserData.fromJson(Map<String, dynamic> json) => MatchUserData(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        bio: json["bio"] ?? "",
        verified: json["verified"] ?? "",
        images: List<UserImage>.from(
            (json["images"] ?? []).map((x) => UserImage.fromJson(x ?? {}))),
        distance: (json["distance"] ?? 0).toString(),
        age: json["age"] ?? 0,
        activeTime: json["active_time"] ?? "",
        interest: List<Interest>.from(
            (json["interest"] ?? []).map((x) => Interest.fromJson(x ?? {}))),
        // prompts: List<Prompt>.from((json["prompts"] ?? []).map((x) => Prompt.fromJson(x ?? {}))),
        percentage: json["percentage"] ?? 0,
        basic: Basic.fromJson(json["basic"] ?? {}),
        languages: json["languages"] ?? "",
        lastMessage: LastMessage.fromJson(
            json["last_message"].toString() == "[]"
                ? {}
                : json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "verified": verified,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "distance": distance,
        "age": age,
        "active_time": activeTime,
        "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
        // "prompts": List<dynamic>.from(prompts.map((x) => x.toJson())),
        "percentage": percentage,
        "basic": basic.toJson(),
        "languages": languages,
        "last_message": lastMessage.toJson(),
      };
}

class Basic {
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

class UserImage {
  String imageUrl;

  UserImage({
    required this.imageUrl,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        imageUrl: json["image_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class Interest {
  String name;

  Interest({
    required this.name,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class LastMessage {
  String messageText;
  String isSeen;
  bool clientMessage;

  LastMessage({
    required this.messageText,
    required this.isSeen,
    required this.clientMessage,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        messageText: json["message_text"] ?? "",
        isSeen: (json["is_seen"] ?? 0).toString(),
        clientMessage: json["client_message"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "message_text": messageText,
        "is_seen": isSeen,
        "client_message": clientMessage,
      };
}

// class Prompt {
//   String question;
//   String promptId;
//   String answer;
//
//   Prompt({
//     this.question,
//     this.promptId,
//     this.answer,
//   });
//
//   factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
//     question: json["question"],
//     promptId: json["prompt_id"],
//     answer: json["answer"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "question": question,
//     "prompt_id": promptId,
//     "answer": answer,
//   };
// }
