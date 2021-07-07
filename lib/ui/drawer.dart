import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/auth.dart';
import '../auth/services/service.dart';

const String avatarImageRoot = "assets/images/avatars/";
const String defaultAvatar = avatarImageRoot + "avatar_1.png";
const images = <String>[
  "avatar_1.png",
  "avatar_2.png",
  "avatar_3.png",
  "avatar_4.png",
  "avatar_5.png",
  "avatar_6.png",
  "avatar_7.png",
  "avatar_8.png",
];

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  TextEditingController _controller;
  FocusNode _focusNode;
  bool _editingEnabled = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller =
        TextEditingController(text: AuthServices.userProfile.username);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Column(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      String newAvatar = await showModalBottomSheet<String>(
                          context: context,
                          builder: (context) => AvatarSelector());
                      if (newAvatar != null)
                        this.setState(() {
                          AuthServices.userProfile.avatar = newAvatar;
                        });
                    },
                    child: Card(
                      elevation: 2.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.asset(
                            AuthServices.userProfile.avatar ?? defaultAvatar,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    EditableText(
                      focusNode: _focusNode,
                      controller: _controller,
                      readOnly: !_editingEnabled,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                      backgroundCursorColor: Colors.black,
                      cursorColor:
                          Theme.of(context).textSelectionTheme.cursorColor,
                    ),
                    IconButton(
                      icon: Icon(_editingEnabled ? Icons.done : Icons.edit),
                      onPressed: () {
                        this.setState(
                          () => _editingEnabled = !_editingEnabled,
                        );
                        if (_editingEnabled) {
                          _focusNode.requestFocus();
                        } else {
                          AuthServices.changeUsername(_controller.text.trim())
                              .catchError((_) => this._controller.text =
                                  AuthServices.userProfile.username);
                          _focusNode.unfocus();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Headsup! Community"),
            onTap: () => launch("https://www.instagram.com/ishi_says/"),
          ),
          Container(
            height: 56.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text("Chat with Ishi"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
                  child: Image.asset("assets/images/comingsoon_label.png"),
                ),
              ],
            ),
          ),
          Container(
            height: 56.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text("Book a session"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
                  child: Image.asset("assets/images/comingsoon_label.png"),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              AuthServices.logout();
              Navigator.pushReplacementNamed(context, AuthForm.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class AvatarSelector extends StatefulWidget {
  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          images.length,
          (index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pop(avatarImageRoot + images[index]),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  avatarImageRoot + images[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
