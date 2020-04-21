import 'dart:ui';

import 'package:Spark/models/user.dart';
import 'package:Spark/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/chat.dart';
import 'package:Spark/screens/chat_profile.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/models/userData.dart';
import 'package:provider/provider.dart';

class MessageTab extends StatefulWidget {
  final UserData userData;
  final messages; //TODO: Prob not a good idea to have two copies of this in memory!

  MessageTab({this.userData, this.messages});

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    int messageCount = List.of(widget.messages).length;
    var sigma = widget.userData.isBlurred ? 5.0 : 0.0;

    return InkWell(
      highlightColor: Colors.red[200].withOpacity(0.1),
      enableFeedback: true,
      splashColor: Colors.teal[100],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (_) => ChatProfile(
                      userData: widget.userData,
                      messages: widget.messages,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
        child: Row(children: <Widget>[
          SizedBox(width: 16),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 34,
                backgroundImage: AssetImage(widget.userData.getMainImage()),
              ),
                ClipOval(  // <-- clips to the child Containers dimensions
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX:sigma, sigmaY: sigma),
                    child: Container(
                      alignment: Alignment.center,
                      width: 68.0,
                      height: 68.0,
                      child: Text(" "),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(widget.userData.firstname,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 17),
                  Text(widget.userData.profession,
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(169, 176, 182, 1),
                          fontFamily: 'Nunito')),
                ],
              ),
              Text(
                  messageCount > 0
                      ? widget.messages.last.content
                      : "", //TODO: Some sensible default msg
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(85, 99, 110, 1),
                      fontFamily: 'Nunito')),
              SizedBox(
                height: 6,
              ),
              Text("1 minute ago",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(171, 176, 180, 1),
                      fontFamily: 'Nunito'))
            ],
          )
        ]),
      ),
    );
  }
}

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    final myUid = Provider.of<User>(context).uid;
    List<Chat> uid1Chats =
        Provider.of<List<Uid1Chat>>(context).map<Chat>((Uid1Chat chat) {
      return Chat(chat.uid1, chat.uid2, chat.count, chat.messages);
    }).toList();
    List<Chat> uid2Chats =
        Provider.of<List<Uid2Chat>>(context).map<Chat>((Uid2Chat chat) {
      return Chat(chat.uid1, chat.uid2, chat.count, chat.messages);
    }).toList();
    List<Chat> chats = uid1Chats + uid2Chats;

    return Scaffold(
      appBar: buildAppBar("Messages", List()),
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (_, index) {
            var chat = chats[index];
            var theirUid = chat.uid1 == myUid ? chat.uid2 : chat.uid1;

            return FutureBuilder<UserData>(
                future: UserService(uid: myUid).getUserDocFutureFromUid(theirUid),
                builder: (_, userDataSnapshot) {
                  if (userDataSnapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
                  } 
                  else if (userDataSnapshot.data != null) {
                    return MessageTab(
                        userData: userDataSnapshot.data,
                        messages: chat.messages);
                  }
                  else {
                    return Container(child:Text("Returned UserData==null for UID:" + theirUid + "\n"));
                  }
                });
          }),
    );
  }
}
