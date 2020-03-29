import 'package:flutter/material.dart';
import 'package:Spark/screens/chat.dart';
import 'package:Spark/screens/profile.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/models/userData.dart';

class ChatProfile extends StatefulWidget {
  final String myUid;
  final UserData userData;
  final messages;

  ChatProfile({this.myUid, this.userData, this.messages});

  @override
  _ChatProfileState createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildChatProfileAppBar(widget.userData.firstname, widget.userData.imagepath),
        body: TabBarView(
          children: <Widget>[
            ChatView(myUid: widget.myUid, theirUid: widget.userData.uid, messages: widget.messages), 
            Profile(widget.userData)
            ],
        ),
      ),
    );
  }
}
