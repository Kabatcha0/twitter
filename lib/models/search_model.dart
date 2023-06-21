class SearchModel {
  late String email;
  late String name;
  late String bio;
  late String cover;
  late String pass;
  late String profile;
  late String uid;
  SearchModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
    cover = json['cover'];
    pass = json['pass'];
    profile = json['profile'];
    uid = json['uid'];
  }
}
