import 'package:intl/intl.dart';

import '../model/serializers.dart';

Map<String, List<DiaryEntry>> groupDiaryByDate(List<DiaryEntry> diaries) {
  Map ret = Map<String, List<DiaryEntry>>();

  diaries.forEach((diary) {
    String key = readableDateFormat(diary.created);

    if (ret.containsKey(key)) {
      ret[key].add(diary);
    } else {
      ret[key] = List<DiaryEntry>.empty(growable: true);
      ret[key].add(diary);
    }
  });

  return ret;
}

String readableDateFormat(DateTime dateTime) {
  DateTime now = DateTime.now();

  // if same date return today
  if (dateTime.day == now.day &&
      dateTime.month == now.month &&
      dateTime.year == now.year) {
    return 'Today';
  }

  // if same year return MMM DD
  if (dateTime.year == now.year) {
    return DateFormat.MMMd().format(dateTime);
  }

  return DateFormat.yMMMd().format(dateTime);
}
