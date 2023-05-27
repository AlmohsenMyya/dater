import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  String response;
  List<UserDetails> msg;
  String token;
  int statusCode;

  UserDetailsModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    response: json["response"] ?? "",
    msg: List<UserDetails>.from((json["msg"] ?? []).map((x) => UserDetails.fromJson(x))),
    token: json["token"] ?? "",
    statusCode: json["status_code"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    // "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "token": token,
    "status_code": statusCode,
  };
}

class UserDetails {
  String? id;
  String? name;
  String? bio;
  String? verified;
  String? homeTown;
  List<String>? languages;
  String? starSign;
  String? countriesGetId;
  List<UserImage>? images;
  String? distance;
  String? age;
  String? activeTime;
  List<Interest>? interest;
  List<Prompt>? prompts;
  int? percentage;
  String? country;
  Basic? basic;

  UserDetails({
    this.id,
    this.name,
    this.bio,
    this.verified,
    this.homeTown,
    this.languages,
    this.starSign,
    this.countriesGetId,
    this.images,
    this.distance,
    this.age,
    this.activeTime,
    this.interest,
    this.prompts,
    this.percentage,
    this.country,
    this.basic,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    bio: json["bio"] ?? "",
    verified: json["verified"] ?? "",
    homeTown: json["home_town"] ?? "",
    languages: List<String>.from((json["languages"] ?? []).map((x) => x ?? {})),
    starSign: json["star_sign"] ?? "",
    countriesGetId: json["countries_get_id"] ?? "",
    images: List<UserImage>.from((json["images"] ?? []).map((x) => UserImage.fromJson(x ?? {}))),
    distance: (json["distance"] ?? 0).toString(),
    age: (json["age"] ?? 0).toString(),
    activeTime: json["active_time"] ?? "",
    interest: List<Interest>.from((json["interest"] ?? []).map((x) => Interest.fromJson(x ?? {}))),
    prompts: List<Prompt>.from((json["prompts"] ?? []).map((x) => Prompt.fromJson(x ?? {}))),
    percentage: json["percentage"] ?? 0,
    country: json["country"] ?? "",
    basic: Basic.fromJson(json["basic"] ?? {}),
  );

 /* Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bio": bio,
    "verified": verified,
    "home_town": homeTown,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "star_sign": starSign,
    "countries_get_id": countriesGetId,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "distance": distance,
    "age": age,
    "active_time": activeTime,
    "interest": List<dynamic>.from(interest.map((x) => x.toJson())),
    "prompts": List<dynamic>.from(prompts.map((x) => x.toJson())),
    "percentage": percentage,
    "country": country,
    "basic": basic.toJson(),
  };*/
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
  String lookingFor;

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
    required this.lookingFor,
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
    lookingFor: json["looking_for"] ?? "",
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
    "looking_for": lookingFor,
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

/*UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    required this.response,
    required this.msg,
    required this.token,
    required this.statusCode,
  });

  String response;
  List<UserDetails> msg;
  String token;
  int statusCode;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    response: json["response"] ?? "",
    msg: List<UserDetails>.from((json["msg"] ?? []).map((x) => UserDetails.fromJson(x ?? {}))),
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

class UserDetails {
  UserDetails({
    this.id,
    this.name,
    this.genderGet,
    this.yearOfBirth,
    this.profilePrompts,
    this.bio,
    this.work,
    this.education,
    // required this.updatedAt,
    this.verified,
    this.genderGetId,
    this.distance,
    this.age,
    this.activeTime,
    this.interest,
  });

  String? id;
  String? name;
  String? genderGet;
  String? yearOfBirth;
  String? profilePrompts;
  String? bio;
  String? work;
  String? education;
  // DateTime updatedAt;
  String? verified;
  String? genderGetId;
  String? distance;
  String? age;
  String? activeTime;
  List<Interest>? interest;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    genderGet: json["gender_get"] ?? "",
    yearOfBirth: json["year_of_birth"] ?? "",
    profilePrompts: json["profile_prompts"] ?? "",
    bio: json["bio"] ?? "",
    work: json["work"] ?? "",
    education: json["education"],
    // updatedAt: DateTime.parse(json["updated_at"]),
    verified: json["verified"] ?? "",
    genderGetId: json["gender_get_id"] ?? "",
    distance: json["distance"].toString(),
    age: json["age"].toString(),
    activeTime: json["active_time"] ?? "",
    interest: List<Interest>.from((json["interest"] ?? []).map((x) => Interest.fromJson(x ?? {}))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender_get": genderGet,
    "year_of_birth": yearOfBirth,
    "profile_prompts": profilePrompts,
    "bio": bio,
    "work": work,
    "education": education,
    // "updated_at": updatedAt.toIso8601String(),
    "verified": verified,
    "gender_get_id": genderGetId,
    "distance": distance,
    "age": age,
    "active_time": activeTime,
    "interest": List<dynamic>.from(interest!.map((x) => x.toJson())),
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
}*/
