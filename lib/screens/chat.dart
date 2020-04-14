import 'dart:async';

import 'package:Spark/services/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/chat.dart';
import 'package:Spark/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  final theirUid;
  final image;
  final name;

  ChatView({this.theirUid, this.image, this.name});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var _myUid;
  List<Chat> _chatList;
  Chat _chat;
  var _scrollController = ScrollController();
  var _textController = TextEditingController();
  bool _showEmojiKeyboard = false;
  //FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();

    //_textFieldFocusNode = FocusNode();
    //_textFieldFocusNode.addListener(() {
      //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    //});
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    //_textFieldFocusNode.dispose();
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  // This method cleans the user input before saving to the database
  _cleanText(String inputText) {
    return (inputText != null && inputText.isNotEmpty)
        ? inputText.trim()
        : inputText;
  }

  _buildEmojiPicker() {
    return Container(
      height: _showEmojiKeyboard ? 285 : 0,
      //color: Colors.red,
      child: EmojiPicker(
        bgColor: Colors.transparent,
        rows: 4,
        columns: 8,
        buttonMode: ButtonMode.MATERIAL,
        indicatorColor: Theme.of(context).primaryColor,
        noRecentsStyle: TextStyle(fontFamily: "Nunito", fontSize: 30),
        //recommendKeywords: ["laugh"],
        //numRecommended: 10,
        onEmojiSelected: (emoji, category) {
          _textController.text += emoji.emoji;
        },
      ),
    );
  }

  _buildMessageComposer(BuildContext _context, TextEditingController _textController) {
    return Container(
        padding: EdgeInsets.only(bottom: 5),
        height: 60,
        child: Row(children: <Widget>[
          GestureDetector(
              child: _showEmojiKeyboard
                  ? GestureDetector(
                      child: Icon(
                      Icons.keyboard,
                      size: 30,
                      color: Colors.grey,
                    ))
                  : Image.asset(
                      "icons/smile.png",
                      height: 30,
                      color: Colors.grey,
                    ),
              onTap: () {
                setState(() {
                  _showEmojiKeyboard = !_showEmojiKeyboard;
                });
                if (_showEmojiKeyboard) {
                  FocusScope.of(context).unfocus(); //Hide Keyboard
                } else {
                  //_textFieldFocusNode.requestFocus();
                }
              }),
          SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            child: TextField(
              controller: _textController,
              //focusNode: _textFieldFocusNode,
              //minLines: null,
              //maxLines: null,
              maxLength: 500,
              maxLengthEnforced: true,
              //autofocus: true,
              //expands: true,
              textAlignVertical: TextAlignVertical.bottom,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Type a message",
                hintStyle: TextStyle(color: Colors.grey[400]),
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, 
                      width: 2.0
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          )),
          SizedBox(width: 4,),
          ButtonTheme(
            minWidth: 10,
            child: RaisedButton(
              child: Image.asset("icons/send.png", color: Colors.white, height: 40,),
              color: Theme.of(context).accentColor,
              elevation: 1,
              padding: EdgeInsets.only(left: 14, right: 12, top: 14, bottom: 14),
              shape: CircleBorder(),
              onPressed: () {
                String cleanedText = _cleanText(_textController.text);
                if (cleanedText.isNotEmpty) {
                  var message = Message(
                      content: cleanedText,
                      createdAt: Timestamp.now(),
                      userUid: _myUid);
                  setState(() {
                    _chat.messages.add(message);
                  });
                  ChatsService(myUid: _myUid)
                      .createMessage(widget.theirUid, message);
                  _textController.clear();
                }
              },
            ),
          ),
        ]));
  }

  _buildAlertDialog(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Text(
        "Unsend Message?",
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            }),
        FlatButton(
            child: Text(
              "Unsend",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
      ],
    );
  }

  _buildMessage(Message message) {
    String text = message.content;
    bool isMe = message.userUid == _myUid;
    bool hasEmoji = EmojiParser().hasEmoji(text);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        child: Container(
          margin: isMe
              ? EdgeInsets.only(top: 3, bottom: 3)
              : EdgeInsets.only(top: 4, bottom: 4),
          child: Material(
            elevation: hasEmoji ? 0 : isMe ? 1 : 0.5,
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
            color: hasEmoji
                ? Colors.transparent
                : isMe
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(240, 244, 253, 1),
            child: Container(
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontFamily: "Nunito",
                    fontSize: hasEmoji ? 35 : 15,
                    fontWeight: FontWeight.w500),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
          ),
        ),
        onLongPress: () async {
          HapticFeedback.mediumImpact();
          if (isMe) {
            await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => _buildAlertDialog(context),
            ).then<bool>((shouldDelete) {
              HapticFeedback.heavyImpact();
              if (shouldDelete) {
                setState(() {
                  ChatsService().deleteMessage(message);
                  _chat.messages.removeWhere((msg) => msg == message);
                });
              }
            });
          }
        },
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    _myUid = Provider.of<User>(context).uid;
    _chatList = Provider.of<List<Chat>>(context);
    _chat = (_chatList == null || _chatList.length == 0)
        ? Chat("", "", 0, List()) //TODO: Fix this!
        : _chatList[0];

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    //   });

    // Timer(Duration(milliseconds: 500), () {
    //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    //   }
    // );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListView.builder(
                    controller: _scrollController,
                    addSemanticIndexes: true,
                    itemCount: _chat.messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(_chat.messages[index]);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              _buildMessageComposer(context, _textController),
              //_buildEmojiPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
