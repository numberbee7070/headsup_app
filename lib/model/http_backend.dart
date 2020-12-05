import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../auth/services/service.dart';
import '../model/serializers.dart';
import '../utils/diary_grouping.dart';

const BASE_URI = "https://mentalheadsup.com/api/";

Future<Map<String, dynamic>> createDiaryEntry(
  DiaryEntry diaryEntry,
  File image, {
  bool update: false,
}) async {
  final uri = update ? "diary/${diaryEntry.id}" : "diary/";
  final method = update ? "PATCH" : "POST";
  var diaryRequest = http.MultipartRequest(
    method,
    Uri.parse(BASE_URI + uri),
  );
  diaryRequest.headers.addAll(await AuthServices.authHeader);

  // attach file
  if (image != null) {
    final mimeType = lookupMimeType(image.path).split('/');
    final file = await http.MultipartFile.fromPath("image", image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    diaryRequest.files.add(file);
  }

  // diary text
  diaryRequest.fields['content'] = diaryEntry.content;

  try {
    final streamedResponse = await diaryRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return json.decode(response.body) as Map<String, dynamic>;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Map<String, List<DiaryEntry>>> fetchDiaryEntries() async {
  try {
    http.Response res = await http.get(BASE_URI + "diary/",
        headers: await AuthServices.authHeader);
    List l = jsonDecode(res.body) as List;
    List<DiaryEntry> diaries =
        l.map((obj) => DiaryEntry.fromJson(obj)).toList();
    return groupDiaryByDate(diaries);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<Article>> fetchArticles() async {
  try {
    http.Response res = await http.get(BASE_URI + "articles/",
        headers: await AuthServices.authHeader);
    List l = jsonDecode(res.body) as List;
    List<Article> articles = l.map((obj) => Article.fromJson(obj)).toList();
    return articles;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<Article> fetchArticle(int idx) async {
  try {
    http.Response res = await http.get(BASE_URI + "articles/$idx",
        headers: await AuthServices.authHeader);
    Map data = jsonDecode(res.body) as Map;
    return Article.fromJson(data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future addArticleFavourite(int idx) async {
  try {
    http.Response res = await http.put(BASE_URI + "favourite/$idx",
        headers: await AuthServices.authHeader);
    Map data = jsonDecode(res.body) as Map;
    return Article.fromJson(data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future removeArticleFavourite(int idx) async {
  try {
    http.Response res = await http.delete(BASE_URI + "favourite/$idx",
        headers: await AuthServices.authHeader);
    Map data = jsonDecode(res.body) as Map;
    return Article.fromJson(data);
  } catch (e) {
    print(e);
    rethrow;
  }
}
