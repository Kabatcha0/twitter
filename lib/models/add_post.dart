class AddPosts {
  late String uid;
  late String text;
  late String image;
  late String dateTime;
  late String name;
  late String profile;

  AddPosts({
    required this.dateTime,
    required this.image,
    required this.text,
    required this.uid,
    required this.name,
    required this.profile,
    // required this.likes
  });
  AddPosts.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    text = json["text"];
    image = json["image"];
    dateTime = json["dateTime"];
    name = json["name"];
    profile = json["profile"];
  }
  Map<String, dynamic> toJson({
    required String uid,
    required String text,
    required String image,
    required String dateTime,
    required String name,
    required String profile,
  }) {
    return {
      "uid": uid,
      "text": text,
      "image": image,
      "dateTime": dateTime,
      "name": name,
      "profile": profile
    };
  }
}
