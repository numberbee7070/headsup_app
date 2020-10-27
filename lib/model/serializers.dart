import 'package:json_annotation/json_annotation.dart';

part 'serializers.g.dart';

@JsonSerializable()
class DiaryEntry {
  final String text;
  final DateTime datetime;
  @JsonKey(nullable: true)
  final String imageurl;

  DiaryEntry({this.text, this.imageurl, this.datetime});
  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}

@JsonSerializable()
class Article {
  final String title;
  final String imageurl;
  @JsonKey(nullable: true)
  final String text;

  Article({this.title, this.text, this.imageurl});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
