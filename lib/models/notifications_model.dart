class NotificationsModel {
  late String timeStamp;
  late String id;
  late String text;
  late String uid;
  NotificationsModel({
    required this.id,
    required this.text,
    required this.timeStamp,
    required this.uid,
  });
  NotificationsModel.fromJson(Map<String, dynamic> json) {
    timeStamp = json["timeStamp"];
    id = json["id"];
    text = json["text"];
    uid = json["uid"];
  }
  Map<String, dynamic> toMap({
    required String timeStamp,
    required String id,
    required String text,
    required String uid,
  }) {
    return {
      "timeStamp": timeStamp,
      "id": id,
      "text": text,
      "uid": uid,
    };
  }
}
