import 'dart:convert';

import 'package:app/model/serializers.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../auth/services/service.dart';

final BASE_URI = "https://kyukey.tech/headsup/";

Future<Map<String, dynamic>> createDiaryEntry(
  DiaryEntry diaryEntry,
  File image,
) async {
  final mimeType = lookupMimeType(image.path).split('/');

  final diaryRequest = http.MultipartRequest(
    'POST',
    Uri.parse(BASE_URI + "diary/"),
  );

  final token = await AuthServices.accessToken;
  diaryRequest.headers.addAll({"Authorization": "Token $token"});

  final file = await http.MultipartFile.fromPath("image", image.path,
      contentType: MediaType(mimeType[0], mimeType[1]));
  diaryRequest.files.add(file);
  diaryRequest.fields['text'] = diaryEntry.text;

  try {
    final streamedResponse = await diaryRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    print('${response.statusCode}: ${response.body}');
    return json.decode(response.body) as Map<String, dynamic>;
  } catch (e) {
    print(e);
    return null;
  }
}
