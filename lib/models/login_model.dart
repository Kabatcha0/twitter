class LoginModel {
  late String email;
  late String name;
  late String bio;
  late String cover;
  late String pass;
  late String profile;
  late String uid;
  LoginModel(
      {required this.email,
      required this.name,
      required this.bio,
      required this.cover,
      required this.pass,
      required this.profile,
      required this.uid});
  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
    cover = json['cover'];
    pass = json['pass'];
    profile = json['profile'];
    uid = json['uid'];
  }
  Map<String, dynamic> toJson(
      {required String email,
      required String name,
      required String bio,
      required String cover,
      required String pass,
      required String profile,
      required String uid}) {
    return {
      "email": email,
      "name": name,
      "bio": bio,
      "cover": cover,
      "pass": pass,
      "profile": profile,
      "uid": uid
    };
  }
}
