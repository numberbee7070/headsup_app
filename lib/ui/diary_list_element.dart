import 'package:flutter/material.dart';

import '../model/serializers.dart';

class DiaryListElement extends StatelessWidget {
  final List<DiaryEntry> diaries;
  final String date;
  final Function(DiaryEntry, String, int) editCallback;

  DiaryListElement(
      {Key key,
      @required this.date,
      @required this.diaries,
      @required this.editCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
      diaries.length,
      (index) {
        var image = (diaries[index].imageFile == null
            ? diaries[index].image != null
                ? Image.network(diaries[index].image)
                : null
            : Image.file(diaries[index].imageFile));
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: image,
            title: Text(diaries[index].content),
            onTap: () => this.editCallback(diaries[index], date, index),
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
