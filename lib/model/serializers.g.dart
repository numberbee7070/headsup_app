// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return DiaryEntry(
    content: json['content'] as String,
    image: json['image'] as String,
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
  );
}

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'content': instance.content,
      'datetime': instance.datetime?.toIso8601String(),
      'image': instance.image,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    chapter: (json['chapter'] as num)?.toDouble(),
    body: (json['body'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    imageurl: json['imageurl'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'chapter': instance.chapter,
      'imageurl': instance.imageurl,
      'body': instance.body,
    };
