import 'package:flutter/material.dart';
import 'package:Spark/models/userData.dart';
import 'package:Spark/screens/chat_profile.dart';
import 'package:Spark/services/auth.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:provider/provider.dart';

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
            radius: 30,
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
                  SizedBox(width: 15),
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
                height: 4,
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
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _userDataList = Provider.of<List<UserData>>(context);

    return Scaffold(
        appBar: buildMessagesAppBar(),
        body: ListView.builder(
          itemCount: _userDataList == null
              ? 0
              : _userDataList.length, // Why is this object sometimes null???
          itemBuilder: (BuildContext context, int index) {
            if (_userDataList != null) {
              return MessageTab(_userDataList[index]);
            }
            return null;
          },
        ));
  }
}
