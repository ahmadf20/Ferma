import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    this.id,
    this.username,
    this.name,
    this.location,
    this.profilePicture,
    this.email,
  });

  String? id;
  String? username;
  String? name;
  String? location;
  String? profilePicture;
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"]?.toString(),
        username: json["username"]?.toString(),
        name: json["name"]?.toString(),
        location: json["location"]?.toString(),
        profilePicture: json["profile_picture"]?.toString(),
        email: json["email"]?.toString(),
      );
}
