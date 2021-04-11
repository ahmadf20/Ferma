import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.name,
    this.location,
    this.activePlant,
    this.profilePicture,
    this.email,
  });

  String? id;
  String? username;
  String? name;
  String? location;
  String? activePlant;
  String? profilePicture;
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        location: json["location"],
        activePlant: json["active_plant"].toString(),
        profilePicture: json["profile_picture"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "location": location,
        "active_plant": activePlant,
        "profile_picture": profilePicture,
        "email": email,
      };
}
