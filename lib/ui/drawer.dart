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
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                FlatButton(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        AuthServices.userProfile.avatar ?? defaultAvatar,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                  ),
                ),
                Text(AuthServices.userProfile.username),
              ],
            ),
          ),
          ListTile(
            title: Text("Headsup! Community"),
            onTap: () => launch("https://www.instagram.com/ishi_says/"),
          ),
          ListTile(
            title: Text("Chat with Ishi"),
          ),
          ListTile(
            title: Text("Book a session"),
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
