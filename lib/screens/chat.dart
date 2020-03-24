import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/chat.dart';

class ChatView extends StatefulWidget {
  final image;
  final name;
  final messages;

  ChatView({this.image, this.name, this.messages}) {
    if (image == null || name == null || messages == null) {
      AlertDialog(
        title: Text(
            "Cant instantiate a ChatView without an Image, Name and messages"),
      );
    }
  }

  @override
  _ChatViewState createState() => _ChatViewState(messages);
}

class _ChatViewState extends State<ChatView> {
  var _inputText;
  var _switchState = false;
  var _messages;

  _ChatViewState(List<Message> messages) {
    _messages = messages;
  }

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
                _messages.add(Message(
                    content: _inputText,
                    createdAt: Timestamp.now(),
                    uid: "MyUID")); //TODO: Need to pass down Current
              });
            },
          )
        ]));
  }

  _buildMessage({String text, bool isMe}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isMe
            ? EdgeInsets.only(top: 5, bottom: 5)
            : EdgeInsets.only(top: 5, bottom: 5),
        child: Material(
          elevation: 1,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))
              : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          color: isMe
              ? Color.fromRGBO(1, 170, 185, 1)
              : Color.fromRGBO(240, 244, 253, 1),
          child: Container(
            child: Text(
              text,
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontFamily: "Nunito",
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                //reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(
                      text: _messages[index].content, isMe: _switchState);
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
