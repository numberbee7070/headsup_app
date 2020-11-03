import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'serializers.g.dart';

@JsonSerializable()
class DiaryEntry {
  final String content;
  final DateTime created;
  @JsonKey(nullable: true)
  final String image;
  @JsonKey(ignore: true)
  File imageFile;

  DiaryEntry({this.content, this.image, this.created, this.imageFile});
  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}

@JsonSerializable()
class Article {
  final int id;
  final String image;
  final String title;
  @JsonKey(nullable: true)
  final String body;
  @JsonKey(nullable: true)
  final String audio;

  Article({this.id, this.title, this.body, this.image, this.audio});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
