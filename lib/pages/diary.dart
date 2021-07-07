import 'dart:io';
import 'dart:ui';

import 'package:app/ui/diary_list_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../model/http_backend.dart';
import '../model/serializers.dart';

class Diary extends StatefulWidget {
  static String routeName = "diary";
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  File _imageFile;
  Future _future;
  Map<String, List<DiaryEntry>> items = {};
  TextEditingController textController = TextEditingController();

  DiaryEntry _editDiary;
  String _editDate;
  int _editIdx;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _future = loadDiary();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.4),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken),
                    image: _imageFile != null
                        ? FileImage(_imageFile)
                        : _editDiary != null && _editDiary.image != null
                            ? NetworkImage(_editDiary.image)
                            : AssetImage("assets/images/diary.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: selectImage,
                        style: TextButton.styleFrom(shape: CircleBorder()),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: textController,
                        style: TextStyle(color: Colors.white),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Whats up in your mind?",
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: insertDiary,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int idx) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DiaryListElement(
                        date: items.keys.elementAt(idx),
                        diaries: items.values.elementAt(idx),
                        editCallback: editDiaryCallback,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void insertDiary() {
    if (textController.text.trim() == "") {
      return;
    }

    if (_editDiary == null) {
      var obj = DiaryEntry(
        content: textController.text.trim(),
        imageFile: _imageFile,
      );

      if (!items.containsKey('Today')) {
        items = {
          'Today': List<DiaryEntry>.empty(growable: true),
          ...this.items
        };
      }

      items['Today'].insert(0, obj);

      createDiaryEntry(obj, _imageFile);
    } else {
      var obj = DiaryEntry(
        id: items[_editDate][_editIdx]?.id,
        content: textController.text.trim(),
        image: _editDiary?.image,
        imageFile: _imageFile,
      );

      items[_editDate][_editIdx] = obj;

      createDiaryEntry(obj, _imageFile, update: true);
    }

    _imageFile = null;
    _editDiary = null;
    _editDate = null;
    _editIdx = null;
    textController.text = '';

    this.setState(() {});
  }

  Future<void> selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        this.setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No image selected.")));
      }
    });
  }

  Future loadDiary() async {
    this.items = await fetchDiaryEntries();
  }

  Future editDiaryCallback(DiaryEntry diary, String date, int idx) async {
    textController.text = diary.content;
    this.setState(() {
      _imageFile = null;
      _editDiary = diary;
      _editDate = date;
      _editIdx = idx;
    });
  }
}
