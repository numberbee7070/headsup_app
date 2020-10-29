import 'package:json_annotation/json_annotation.dart';

part 'serializers.g.dart';

@JsonSerializable()
class DiaryEntry {
  final String content;
  final DateTime datetime;
  @JsonKey(nullable: true)
  final String image;

  DiaryEntry({this.content, this.image, this.datetime});
  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}

@JsonSerializable()
class Article {
  final double chapter;
  @JsonKey(nullable: true)
  final String imageurl;
  @JsonKey(nullable: true)
  final Map<String, String> body;

  Article({this.chapter, this.body, this.imageurl});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
