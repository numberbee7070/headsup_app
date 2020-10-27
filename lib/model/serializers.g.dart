// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return DiaryEntry(
    text: json['text'] as String,
    imageurl: json['imageurl'] as String,
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
  );
}

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'text': instance.text,
      'datetime': instance.datetime?.toIso8601String(),
      'imageurl': instance.imageurl,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    title: json['title'] as String,
    text: json['text'] as String,
    imageurl: json['imageurl'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'title': instance.title,
      'imageurl': instance.imageurl,
      'text': instance.text,
    };
