import 'dart:io';
import 'dart:ui';

import 'package:app/ui/diary_list_element.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/http_backend.dart';
import '../model/serializers.dart';

class Diary extends StatefulWidget {
  static String routeName = "diary";
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  File _image;
  Future _future;
  Map<String, List<DiaryEntry>> items;
  TextEditingController textController = TextEditingController();
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: _image != null
                    ? FileImage(_image)
                    : AssetImage("assets/images/diary.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: selectImage,
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Enter message",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: insertDiary,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          ),
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
    this.setState(() {
      if (!items.containsKey('Today')) {
        items = {'Today': List<DiaryEntry>(), ...this.items};
      }

      items['Today'].insert(
          0,
          DiaryEntry(
            content: textController.text.trim(),
            created: DateTime.now(),
            imageFile: this._image,
          ));
    });

    createDiaryEntry(this.items['Today'][0], this._image);
  }

  final picker = ImagePicker();

  Future<void> selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        this.setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("No image selected.")));
        print('No image selected.');
      }
    });
  }

  Future loadDiary() async {
    this.items = await fetchDiaryEntries();
  }
}
