// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return DiaryEntry(
    id: json['id'] as int,
    content: json['content'] as String,
    image: json['image'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'created': instance.created?.toIso8601String(),
      'image': instance.image,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    image: json['image'] as String,
    audio: json['audio'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'body': instance.body,
      'audio': instance.audio,
    };
