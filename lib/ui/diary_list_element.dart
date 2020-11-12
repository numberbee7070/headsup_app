import 'package:flutter/material.dart';

import '../model/serializers.dart';

class DiaryListElement extends StatelessWidget {
  final List<DiaryEntry> diaries;
  final String date;

  DiaryListElement({@required this.date, @required this.diaries});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      diaries.length,
      (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: diaries[index].image == null
              ? Image.file(diaries[index].imageFile)
              : Image.network(diaries[index].image),
          title: Text(diaries[index].content),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(this.date),
        ...items,
      ],
    );
  }
}
