import 'package:Spark/services/chats.dart';
import 'package:Spark/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/chat.dart';
import 'package:Spark/screens/chat_profile.dart';
import 'package:Spark/services/auth.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/models/userData.dart';

class MessageTab extends StatelessWidget {
  String imagePath;
  String firstName;
  String lastMsg;
  String profession;

  MessageTab(UserData userData) {
    imagePath = "images/mawra.jpg";
    firstName = userData.firstname;
    lastMsg = "Hi! How are you?";
    profession = userData.profession;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return InkWell(
      highlightColor: Colors.red[200].withOpacity(0.1),
      enableFeedback: true,
      splashColor: Colors.teal[100],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatProfile(
                      image: imagePath,
                      name: firstName,
                      chats: [],
                    ))); 
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
        child: Row(children: <Widget>[
          SizedBox(width: 16),
          CircleAvatar(
            radius: 34,
            backgroundImage: AssetImage(imagePath),
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
                  Text(firstName,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 17),
                  Text(profession,
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(169, 176, 182, 1),
                          fontFamily: 'Nunito')),
                ],
              ),
              Text(lastMsg,
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
  final String currentUserUid;
  
  const MessageView({Key key, this.currentUserUid}): super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  @override
  Widget build(BuildContext context) {

        return Scaffold(
        appBar: buildMessagesAppBar(),
        body: FutureBuilder<QuerySnapshot>(
          future: ChatsService(myUid: widget.currentUserUid).getUsersChats(),
          builder: (_, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            else {
              return ListView.builder(
                itemCount: chatSnapshot.data.documents.length,
                itemBuilder: (_, index) {
                    var chatData = chatSnapshot.data.documents[index].data;
                    var uid1 = chatData["uid1"];
                    var uid2 = chatData["uid2"];

                    return FutureBuilder<UserData>(
                      future: UserService(uid: uid1).getUserDocFutureFromUid(uid2),
                      builder: (_, userDataSnapshot) {
                        if (userDataSnapshot.connectionState == ConnectionState.waiting) {
                          return Text(""); // Need to find a better way to overcome this delay (why is there always a delay???)
                        }
                        else {
                          return MessageTab(userDataSnapshot.data);
                        }
                      });
                });
            }
          })
        );
      }
}
