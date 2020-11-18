import 'package:flutter/material.dart';

import '../model/serializers.dart';

class DiaryListElement extends StatelessWidget {
  final List<DiaryEntry> diaries;
  final String date;

  DiaryListElement({Key key, @required this.date, @required this.diaries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      diaries.length,
      (index) {
        var image = diaries[index].image == null
            ? diaries[index].imageFile != null
                ? Image.file(diaries[index].imageFile)
                : null
            : Image.network(diaries[index].image);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: image,
            title: Text(diaries[index].content),
          ),
        );
      },
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
