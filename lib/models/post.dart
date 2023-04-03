import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        body: json["body"] ?? "");
  }
  factory Post.fromQuery(QueryDocumentSnapshot<Object?> json) {
    return Post(
        userId: json["userId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        body: json["body"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "id": id.toString(),
    };
  }
}
