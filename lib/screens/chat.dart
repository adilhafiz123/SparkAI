import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final image;
  final name;
  final chats;

  ChatView({this.image, this.name, this.chats}) {
    if (image == null || name == null) {
      AlertDialog(
        title: Text("Cant instantiate a ChatView without an Image and Name"),
      );
    }
  }

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var _inputText;
  var _switchState = false;

  _buildMessageComposer() {
    return Container(
        //padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        color: Colors.white,
        child: Row(children: <Widget>[
          Switch(
            value: _switchState,
            onChanged: (state) {
              setState(() {
                _switchState = state;
              });
            },
          ),
          Expanded(
              child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration.collapsed(
                    hintText: "Type a message",
                  ),
                  onChanged: (text) {
                    setState(() {
                      _inputText = text;
                    });
                  })),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            onPressed: () {
              setState(() {
                widget.chats.add(_inputText);
              });
            },
          )
        ]));
  }

  _buildMessage({String text, bool isMe}) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontFamily: "Nunito",
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
      margin: isMe
          ? EdgeInsets.only(left: 40, top: 8, bottom: 8)
          : EdgeInsets.only(right: 40, top: 8, bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
          color: isMe
              ? Colors.teal //.fromRGBO(215, 2, 101, 1)
              : Color.fromRGBO(240, 244, 253, 1),
          //border: BorderStyle.solid,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))
              : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //_messageList.add("Doing good thanks. How are you today?");
    //_messageList.add("W'Salaam, great thanks! How are you?");
    //_messageList.add("Salaam! How's it going?");
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                reverse: true,
                itemCount: widget.chats.length,
                itemBuilder: (context, index) {
                  return _buildMessage(
                      text: widget.chats[index], isMe: _switchState);
                },
              )),
              _buildMessageComposer()
            ],
          ),
        ),
      ),
    );
  }
}
