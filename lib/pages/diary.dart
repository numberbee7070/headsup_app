import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../ui/bottom_bar.dart';
import '../ui/hamburger_menu.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 15.0),
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter message",
                              ),
                              minLines: 1,
                              maxLines: 5,
                            ),
                          ),
                          RaisedButton(
                            onPressed: null,
                            child: Text("Add"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            HamburgerMenu(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FABMenuButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        _scaffold.currentState
            .showSnackBar(SnackBar(content: Text("No image selected.")));
        print('No image selected.');
      }
    });
  }
}
