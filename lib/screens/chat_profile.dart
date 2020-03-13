import 'package:flutter/material.dart';
import 'package:hello_fluter/screens/chat.dart';
import 'package:hello_fluter/screens/profile.dart';

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
  var _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        titleSpacing: 60,
        title: Row(children: <Widget>[
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(widget.image),
          ),
          SizedBox(
            width: 10,
          ),
          Text(widget.name,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontSize: 24,
                  fontWeight: FontWeight.w700))
        ]),
        backgroundColor: Colors.white, //Color.fromRGBO(215, 2, 101, 1),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ChatView(
            chats: widget.chats
          ),
          Profile(
            image: widget.image,
            name: widget.name,
          )
        ],
      ),
    );
  }
}
