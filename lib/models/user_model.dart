import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String fullName;
  String email;
  String birthdate;
  String? address;
  int? age;

  UserModel({
    this.id,
    this.age,
    required this.fullName,
    required this.email,
    required this.birthdate,
  });

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "birthdate": birthdate,
        "address": address,
        "email": email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      fullName: json["full_name"],
      email: json["email"],
      birthdate: json["birthdate"],
    );
  }
  factory UserModel.fromQuery(QueryDocumentSnapshot json) {
    Object? object = json.data();
    return UserModel(
      id: json.id,
      fullName: json["full_name"],
      age: object.toString().contains("age") ? json["age"] : 0,
      email: json["email"],
      birthdate: json["birthdate"],
    );
  }
}
