import 'dart:io';

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
  List<DiaryEntry> items;
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: Text(
                "Diary",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            decoration: _image != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image),
                      fit: BoxFit.fill,
                    ),
                  )
                : BoxDecoration(color: Colors.blueAccent),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  FlatButton(
                    onPressed: selectImage,
                    child: Text(
                      "choose image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter message",
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(textController.text);
                      if (textController.text.trim() == "") {
                        return;
                      }
                      this.setState(() {
                        this.items.insert(
                            0,
                            DiaryEntry(
                              content: textController.text.trim(),
                              created: DateTime.now(),
                              imageFile: this._image,
                            ));
                      });
                      createDiaryEntry(this.items[0], this._image);
                    },
                    child: Text("Add"),
                  )
                ],
              ),
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
                    itemBuilder: (context, idx) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(items[idx].content),
                        leading: items[idx].image != null
                            ? Image.network(items[idx].image)
                            : Image.file(items[idx].imageFile),
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
