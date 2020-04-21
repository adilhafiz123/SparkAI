import 'package:Spark/services/chats.dart';
import 'package:flutter/material.dart';
import 'package:Spark/screens/chat.dart';
import 'package:Spark/screens/profile.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/models/userData.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/models/chat.dart';
import 'package:provider/provider.dart';

class ChatProfile extends StatefulWidget {
  final UserData userData;
  final messages;

  ChatProfile({this.userData, this.messages});

  @override
  _ChatProfileState createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  @override
  Widget build(BuildContext context) {
    final myUid = Provider.of<User>(context).uid;

    return StreamProvider<List<Chat>>(
      create: (context) => ChatsService().getChatForUid1Uid2(myUid, widget.userData.uid),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildChatProfileAppBar(
              widget.userData.firstname, 
              widget.userData.getMainImage(), 
              widget.userData.isBlurred,
              context,
            ),
          body: TabBarView(
            children: <Widget>[
              ChatView(theirUid: widget.userData.uid),
              Profile(widget.userData)
            ],
          ),
        ),
      ),
    );
  }
}
