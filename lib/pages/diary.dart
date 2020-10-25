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
  final Key _scaffold = GlobalKey<ScaffoldState>();
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
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      image: DecorationImage(
                        image: _image == null ? null : FileImage(_image),
                        fit: BoxFit.fill,
                      ),
                    ),
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
                            child: TextField(
                              minLines: 1,
                              maxLines: 5,
                            ),
                          ),
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
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
