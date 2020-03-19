import 'package:flutter/material.dart';
import 'package:Spark/screens/chat.dart';
import 'package:Spark/shared/profile.dart';
import 'package:Spark/shared/appbar.dart';

class ChatProfile extends StatefulWidget {
  final image;
  final name;
  final chats;

  ChatProfile({this.image, this.name, this.chats}) {
    if (image == null || name == null) {
      AlertDialog(
        title: Text("Cant instantiate a ChatProfile without an Image and Name"),
      );
    }
  }

  @override
  _ChatProfileState createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildChatProfileAppBar(widget.name, widget.image),
        body: TabBarView(
          children: <Widget>[
            ChatView(chats: widget.chats), 
            Profile()
            ],
        ),
      ),
    );
  }
}
