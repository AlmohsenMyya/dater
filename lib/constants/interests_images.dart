import 'dart:developer';

class InterestsImages {
  static const rootPath = "assets/Bambo Interests Icons";

  List<Map<String, dynamic>> folderNames = [
    {"id": 1, "folderName": "Creative"},
    {"id": 2, "folderName": "Sports"},
    {"id": 3, "folderName": "Going Out"},
    {"id": 4, "folderName": "Staying in"},
    {"id": 5, "folderName": "Music"},
    {"id": 6, "folderName": "Film & Tv"},
    {"id": 7, "folderName": "Reading"},
    {"id": 8, "folderName": "Food & Drink"},
    {"id": 9, "folderName": "Traveling"},
    {"id": 10, "folderName": "Pets"},
    {"id": 11, "folderName": "Values & traits"},
  ];

  String getLogoPath(String id) {
    final folderData =
        folderNames.firstWhere((data) => data["id"] == int.parse(id));
    String res = "$rootPath/${folderData["folderName"]}/logo.png";
    log(res);
    return res;
  }

  String getImagePath(String categoryId, String optionId) {
    List<Map<String, dynamic>> category =
        categoryInterests[int.parse(categoryId)] ?? [];

    Map<String, dynamic>? option = category.firstWhere(
      (interest) => interest['id'] == int.parse(optionId),
    );
    return option['image'];
  }

  Map<int, List<Map<String, dynamic>>> categoryInterests = {
    1: [
      {
        "id": 6,
        "name": "Photography",
        "image": "$rootPath/Creative/Photography.png"
      },
      {"id": 7, "name": "Arts", "image": "$rootPath/Creative/Arts.png"},
      {"id": 8, "name": "Arts", "image": "$rootPath/Creative/Design.png"},
      {"id": 9, "name": "Crafts", "image": "$rootPath/Creative/Crafts.png"},
      {"id": 10, "name": "Dancing", "image": "$rootPath/Creative/Dancing.png"},
      {"id": 11, "name": "Mak-UP", "image": "$rootPath/Creative/make-up.png"},
      {
        "id": 12,
        "name": "Making Videos",
        "image": "$rootPath/Creative/making Videos.png"
      },
      {"id": 13, "name": "Writing", "image": "$rootPath/Creative/writing.png"},
      {"id": 14, "name": "Singing", "image": "$rootPath/Creative/Singing.png"},
    ],
    2: [
      {
        "id": 15,
        "name": "Athletics",
        "image": "$rootPath/Sports/Athletics.png"
      },
      {
        "id": 16,
        "name": "Badminton",
        "image": "$rootPath/Sports/Badminton.png"
      },
      {
        "id": 17,
        "name": "Snowboarding",
        "image": "$rootPath/Sports/Snowboarding.png"
      },
      {
        "id": 18,
        "name": "Basketball",
        "image": "$rootPath/Sports/Basketball.png"
      },
      {
        "id": 19,
        "name": "Bouldering",
        "image": "$rootPath/Sports/Bouldering.png"
      },
      {"id": 20, "name": "Bowling", "image": "$rootPath/Sports/Bowling.png"},
      {"id": 21, "name": "Boxing", "image": "$rootPath/Sports/Boxing.png"},
      {"id": 22, "name": "Crew", "image": "$rootPath/Sports/Crew.png"},
      {"id": 23, "name": "Cricket", "image": "$rootPath/Sports/Cricket.png"},
      {
        "id": 24,
        "name": "Gymnastics",
        "image": "$rootPath/Sports/Gymnastics.png"
      },
      {"id": 25, "name": "Cycling", "image": "$rootPath/Sports/Cycling.png"},
      {"id": 26, "name": "Football", "image": "$rootPath/Sports/Football.png"},
      {
        "id": 27,
        "name": "Go Karting",
        "image": "$rootPath/Sports/Go Karting.png"
      },
      {"id": 28, "name": "Surfing", "image": "$rootPath/Sports/Surfing.png"},
      {"id": 29, "name": "Handball", "image": "$rootPath/Sports/Handball.png"},
      {"id": 30, "name": "Hockey", "image": "$rootPath/Sports/Hockey.png"},
      {"id": 32, "name": "Gym", "image": "$rootPath/Sports/Gym.png"},
      {
        "id": 33,
        "name": "Skateboarding",
        "image": "$rootPath/Sports/Skateboarding.png"
      },
      {
        "id": 34,
        "name": "Martial arts",
        "image": "$rootPath/Sports/Martial arts.png"
      },
      {
        "id": 35,
        "name": "Meditation",
        "image": "$rootPath/Sports/Meditation.png"
      },
      {
        "id": 36,
        "name": "Horse riding",
        "image": "$rootPath/Sports/Horse riding.png"
      },
      {"id": 37, "name": "Pilates", "image": "$rootPath/Sports/Pilates.png"},
      {
        "id": 38,
        "name": "Ping Pong",
        "image": "$rootPath/Sports/Ping Pong.png"
      },
      {"id": 39, "name": "Tennis", "image": "$rootPath/Sports/Tennis.png"},
      {
        "id": 40,
        "name": "Volleyball",
        "image": "$rootPath/Sports/Volleyball.png"
      },
      {"id": 41, "name": "Running", "image": "$rootPath/Sports/Running.png"},
      {"id": 42, "name": "Swimming", "image": "$rootPath/Sports/Swimming.png"},
      {"id": 43, "name": "Baseball", "image": "$rootPath/Sports/Baseball.png"},
      {"id": 44, "name": "Skiing", "image": "$rootPath/Sports/Skiing.png"},
      {"id": 45, "name": "Rugby", "image": "$rootPath/Sports/Rugby.png"},
      {"id": 46, "name": "Yoga", "image": "$rootPath/Sports/Yoga.png"},
      {"id": 47, "name": "Golf", "image": "$rootPath/Sports/Golf.png"},
    ],
    3: [
      {"id": 48, "name": "Bars", "image": "$rootPath/Going Out/Bars.png"},
      {
        "id": 49,
        "name": "Museum & Galleries",
        "image": "$rootPath/Going Out/Museums & Galleries.png"
      },
      {
        "id": 50,
        "name": "Cafe-hopping",
        "image": "$rootPath/Going Out/Café-hopping.png"
      },
      {
        "id": 51,
        "name": "Concerts",
        "image": "$rootPath/Going Out/Concerts.png"
      },
      {
        "id": 52,
        "name": "Festivals",
        "image": "$rootPath/Going Out/Festivals.png"
      },
      {"id": 53, "name": "Clubs", "image": "$rootPath/Going Out/Clubs.png"},
      {"id": 54, "name": "Karaoke", "image": "$rootPath/Going Out/Karaoke.png"},
      {
        "id": 55,
        "name": "Stand Up",
        "image": "$rootPath/Going Out/Stand Up.png"
      },
      {"id": 56, "name": "Theater", "image": "$rootPath/Going Out/Theater.png"},
    ],
    4: [
      {"id": 57, "name": "Baking", "image": "$rootPath/Staying in/Baking.png"},
      {
        "id": 58,
        "name": "Board games",
        "image": "$rootPath/Staying in/Board games.png"
      },
      {
        "id": 59,
        "name": "Video games",
        "image": "$rootPath/Staying in/Video games.png"
      },
      {
        "id": 60,
        "name": "Gardening",
        "image": "$rootPath/Staying in/Gardening.png"
      },
      {
        "id": 61,
        "name": "Takeout",
        "image": "$rootPath/Staying in/Takeout.png"
      },
      {
        "id": 62,
        "name": "Cooking",
        "image": "$rootPath/Staying in/Cooking.png"
      },
    ],
    5: [
      {"id": 63, "name": "Hip Hop", "image": "$rootPath/Music/All Music.png"},
      {"id": 64, "name": "Latin", "image": "$rootPath/Music/All Music.png"},
      {"id": 65, "name": "R&B", "image": "$rootPath/Music/All Music.png"},
      {"id": 66, "name": "Country", "image": "$rootPath/Music/All Music.png"},
      {"id": 67, "name": "Afro", "image": "$rootPath/Music/All Music.png"},
      {"id": 68, "name": "Arabs", "image": "$rootPath/Music/All Music.png"},
      {
        "id": 69,
        "name": "Electronics",
        "image": "$rootPath/Music/All Music.png"
      },
      {
        "id": 70,
        "name": "Folk & acoustic",
        "image": "$rootPath/Music/All Music.png"
      },
      {"id": 71, "name": "Classical", "image": "$rootPath/Music/All Music.png"},
      {"id": 72, "name": "Blues", "image": "$rootPath/Music/All Music.png"},
      {"id": 73, "name": "House", "image": "$rootPath/Music/All Music.png"},
      {"id": 74, "name": "Reggae", "image": "$rootPath/Music/All Music.png"},
      {"id": 75, "name": "EDM", "image": "$rootPath/Music/All Music.png"},
      {"id": 76, "name": "Rock", "image": "$rootPath/Music/All Music.png"},
      {"id": 77, "name": "Desi", "image": "$rootPath/Music/All Music.png"},
      {"id": 78, "name": "Rap", "image": "$rootPath/Music/All Music.png"},
      {"id": 79, "name": "Metal", "image": "$rootPath/Music/All Music.png"},
      {"id": 80, "name": "Funk", "image": "$rootPath/Music/All Music.png"},
      {"id": 81, "name": "Techno", "image": "$rootPath/Music/All Music.png"},
      {"id": 82, "name": "Pop", "image": "$rootPath/Music/All Music.png"},
      {"id": 83, "name": "Soul", "image": "$rootPath/Music/All Music.png"},
      {"id": 84, "name": "Indie", "image": "$rootPath/Music/All Music.png"},
      {"id": 85, "name": "Jazz", "image": "$rootPath/Music/All Music.png"},
      {"id": 86, "name": "K-pop", "image": "$rootPath/Music/All Music.png"},
      {"id": 87, "name": "Punk", "image": "$rootPath/Music/All Music.png"},
    ],
    6: [
      {
        "id": 88,
        "name": "Action",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 89,
        "name": "Animation",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 90,
        "name": "Anime",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 91,
        "name": "Drama",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 92,
        "name": "Bollywood",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 93,
        "name": "Comedy",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 94,
        "name": "Indie",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 95,
        "name": "Horror",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 96,
        "name": "Crime",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 97,
        "name": "Rom-com",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 98,
        "name": "K-drama",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 99,
        "name": "Romance",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 100,
        "name": "Documentaries",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 101,
        "name": "Game Shows",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 102,
        "name": "Fantasy",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 103,
        "name": "Reality Shows",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 104,
        "name": "Mystery",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 105,
        "name": "Cooking Show",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 106,
        "name": "Superhero",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 107,
        "name": "Sci-fi",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
      {
        "id": 108,
        "name": "Thriller",
        "image": "$rootPath/Film & Tv/Film & Tv logo.png"
      },
    ],
    7: [
      {"id": 109, "name": "Action", "image": "$rootPath/Reading/Books.png"},
      {
        "id": 110,
        "name": "Biographies",
        "image": "$rootPath/Reading/Books.png"
      },
      {"id": 111, "name": "Crime", "image": "$rootPath/Reading/Books.png"},
      {"id": 112, "name": "Horror", "image": "$rootPath/Reading/Books.png"},
      {"id": 113, "name": "History", "image": "$rootPath/Reading/Books.png"},
      {"id": 114, "name": "Comedy", "image": "$rootPath/Reading/Books.png"},
      {"id": 115, "name": "Classics", "image": "$rootPath/Reading/Books.png"},
      {"id": 116, "name": "Poetry", "image": "$rootPath/Reading/Books.png"},
      {
        "id": 117,
        "name": "Comic Books",
        "image": "$rootPath/Reading/Books.png"
      },
      {"id": 118, "name": "Manga", "image": "$rootPath/Reading/Books.png"},
      {"id": 119, "name": "Sci-fi", "image": "$rootPath/Reading/Books.png"},
      {"id": 120, "name": "Science", "image": "$rootPath/Reading/Books.png"},
      {"id": 121, "name": "Romance", "image": "$rootPath/Reading/Books.png"},
      {"id": 122, "name": "Rom-com", "image": "$rootPath/Reading/Books.png"},
      {"id": 123, "name": "Philosophy", "image": "$rootPath/Reading/Books.png"},
      {"id": 124, "name": "Mystery", "image": "$rootPath/Reading/Books.png"},
      {"id": 125, "name": "Thriller", "image": "$rootPath/Reading/Books.png"},
    ],
    8: [
      {"id": 126, "name": "Beer", "image": "$rootPath/Food & Drink/Beer.png"},
      {
        "id": 127,
        "name": "Coffee",
        "image": "$rootPath/Food & Drink/Coffee.png"
      },
      {
        "id": 128,
        "name": "Whisky",
        "image": "$rootPath/Food & Drink/whisky.png"
      },
      {
        "id": 129,
        "name": "Boba tea",
        "image": "$rootPath/Food & Drink/Boba tea.png"
      },
      {
        "id": 130,
        "name": "Foodie",
        "image": "$rootPath/Food & Drink/Foodie.png"
      },
      {
        "id": 131,
        "name": "Sweet tooth",
        "image": "$rootPath/Food & Drink/Sweet tooth.png"
      },
      {"id": 132, "name": "Sushi", "image": "$rootPath/Food & Drink/Sushi.png"},
      {"id": 133, "name": "Pizza", "image": "$rootPath/Food & Drink/pizza.png"},
      {
        "id": 134,
        "name": "Vegetarian",
        "image": "$rootPath/Food & Drink/Vegetarian.png"
      },
      {"id": 135, "name": "Tacos", "image": "$rootPath/Food & Drink/tacos.png"},
      {"id": 136, "name": "Vegan", "image": "$rootPath/Food & Drink/Vegan.png"},
      {"id": 137, "name": "Tea", "image": "$rootPath/Food & Drink/Tea.png"},
      {"id": 138, "name": "Gin", "image": "$rootPath/Food & Drink/Gin.png"},
      {"id": 139, "name": "Wine", "image": "$rootPath/Food & Drink/wine.png"},
    ],
    9: [
      {
        "id": 140,
        "name": "Backpacking",
        "image": "$rootPath/Traveling/Backpacking.png"
      },
      {
        "id": 141,
        "name": "Beaches",
        "image": "$rootPath/Traveling/Beaches.png"
      },
      {
        "id": 142,
        "name": "Exploring new cities",
        "image": "$rootPath/Traveling/Exploring new cities.png"
      },
      {
        "id": 143,
        "name": "Spa weekends",
        "image": "$rootPath/Traveling/Spa weekends.png"
      },
      {
        "id": 144,
        "name": "Fishing trips",
        "image": "$rootPath/Traveling/Fishing trips.png"
      },
      {
        "id": 145,
        "name": "Hiking trips",
        "image": "$rootPath/Traveling/Hiking trips.png"
      },
      {
        "id": 146,
        "name": "Road trips",
        "image": "$rootPath/Traveling/Road trips.png"
      },
      {
        "id": 147,
        "name": "Staycations",
        "image": "$rootPath/Traveling/Staycations.png"
      },
      {
        "id": 148,
        "name": "Winter Sports",
        "image": "$rootPath/Traveling/Winter Sports.png"
      },
      {
        "id": 149,
        "name": "Camping",
        "image": "$rootPath/Traveling/Camping.png"
      },
    ],
    10: [
      {
        "id": 150,
        "name": "Rabbits",
        "image": "$rootPath/Pets/Rabbits.png"
      },
      {
        "id": 151,
        "name": "Birds",
        "image": "$rootPath/Pets/Birds.png"
      },
      {
        "id": 152,
        "name": "Lizards",
        "image": "$rootPath/Pets/Lizards.png"
      },
      {
        "id": 153,
        "name": "Snakes",
        "image": "$rootPath/Pets/Snakes.png"
      },
      {
        "id": 154,
        "name": "Dogs",
        "image": "$rootPath/Pets/Dogs.png"
      },
      {
        "id": 155,
        "name": "Turtles",
        "image": "$rootPath/Pets/Turtles.png"
      },
      {
        "id": 156,
        "name": "Cats",
        "image": "$rootPath/Pets/Cats.png"
      },
      {
        "id": 157,
        "name": "Fish",
        "image": "$rootPath/Pets/Fish.png"
      },
    ],
    11: [
      {
        "id": 158,
        "name": "Being family-oriented",
        "image": "$rootPath/Values & traits/Being family-oriented.png"
      },
      {
        "id": 159,
        "name": "Self-awareness",
        "image": "$rootPath/Values & traits/Self-awareness.png"
      },
      {
        "id": 160,
        "name": "Being open-minded",
        "image": "$rootPath/Values & traits/Being open-minded.png"
      },
      {
        "id": 161,
        "name": "Being Romantic",
        "image": "$rootPath/Values & traits/Being Romantic.png"
      },
      {
        "id": 162,
        "name": "Positivity",
        "image": "$rootPath/Values & traits/Positivity.png"
      },
      {
        "id": 163,
        "name": "Sense of adventure",
        "image": "$rootPath/Values & traits/sense of adventure.png"
      },
      {
        "id": 164,
        "name": "Empathy",
        "image": "$rootPath/Values & traits/Empathy.png"
      },
      {
        "id": 165,
        "name": "Sense of humor",
        "image": "$rootPath/Values & traits/Sense of humor.png"
      },
      {
        "id": 166,
        "name": "Social awareness",
        "image": "$rootPath/Values & traits/Social awareness.png"
      },
      {
        "id": 167,
        "name": "Intelligence",
        "image": "$rootPath/Values & traits/Intelligence.png"
      },
      {
        "id": 168,
        "name": "Confidence",
        "image": "$rootPath/Values & traits/Confidence.png"
      },
      {
        "id": 169,
        "name": "Creativity",
        "image": "$rootPath/Values & traits/Creativity.png"
      },
      {
        "id": 170,
        "name": "Being active",
        "image": "$rootPath/Values & traits/Being active.png"
      },
      {
        "id": 171,
        "name": "Ambition",
        "image": "$rootPath/Values & traits/Ambition.png"
      },
      {
        "id": 172,
        "name": "Black lives matter",
        "image": "$rootPath/Values & traits/Black lives matter.png"
      },
      {
        "id": 173,
        "name": "Environmentalism",
        "image": "$rootPath/Values & traits/Environmentalism.png"
      },
      {
        "id": 174,
        "name": "Human rights",
        "image": "$rootPath/Values & traits/Human rights.png"
      },
      {
        "id": 175,
        "name": "LGBTQIA + Ally",
        "image": "$rootPath/Values & traits/LGBTQIA + Ally.png"
      },
      {
        "id": 176,
        "name": "Trans ally",
        "image": "$rootPath/Values & traits/Trans ally.png"
      },
      {
        "id": 177,
        "name": "Stop Asian Hate",
        "image": "$rootPath/Values & traits/Stop Asian Hate.png"
      },
      {
        "id": 178,
        "name": "Feminism",
        "image": "$rootPath/Values & traits/Feminism.png"
      },
      {
        "id": 179,
        "name": "Voter rights",
        "image": "$rootPath/Values & traits/Voter rights.png"
      },
    ],
  };
}
