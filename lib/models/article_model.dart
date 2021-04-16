import 'dart:convert';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

class Article {
  Article({
    this.id,
    this.title,
    this.category,
    this.description,
    this.picture,
    this.source,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  int? id;
  String? title;
  String? category;
  String? description;
  String? picture;
  String? source;
  DateTime? createdAt;
  DateTime? updatedAt;
  Author? author;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        picture: json["picture"],
        source: json["source"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );
}

class Author {
  Author({
    this.id,
    this.username,
  });

  String? id;
  String? username;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json['id']?.toString(),
        username: json['username']?.toString(),
      );
}
