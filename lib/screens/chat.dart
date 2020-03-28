import 'package:Spark/services/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/chat.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class ChatView extends StatefulWidget {
  final myUid;
  final theirUid;
  final image;
  final name;
  final messages;

  ChatView({this.myUid, this.theirUid, this.image, this.name, this.messages});

  @override
  _ChatViewState createState() => _ChatViewState(messages);
}

class _ChatViewState extends State<ChatView> {
  var _scrollController = ScrollController();
  var _inputText = "";
  var _textController = TextEditingController();
  List<Message> _messages;
  bool _showEmojiKeyboard = false;
  FocusNode _textFieldFocusNode;

  _ChatViewState(List<Message> messages) {
    _messages = messages;
  }
  @override
  void initState() {
    super.initState();

    _textFieldFocusNode = FocusNode();
    _textFieldFocusNode.addListener( () {
      
    }
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _textFieldFocusNode.dispose();

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
          indicatorColor: Color.fromRGBO(1, 170, 185, 1),
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
              child: _showEmojiKeyboard ? 
              GestureDetector(child:Icon(Icons.keyboard, size: 30,color: Colors.grey,))
              : Image.asset(
                "icons/smile.png",
                height: 30,
                color: Colors.grey,
              ),
              onTap: () {
                setState(() {
                  _showEmojiKeyboard = !_showEmojiKeyboard;
                });
                if(_showEmojiKeyboard) { 
                  FocusScope.of(context).unfocus(); //Hide Keyboard
                }
                else {
                  _textFieldFocusNode.requestFocus();
                }
              }),
          SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            child: TextField(
                controller: _textController,
                focusNode: _textFieldFocusNode,
                //minLines: null,
                //maxLines: null,
                maxLength: 500,
                maxLengthEnforced: true,
                //autofocus: true,
                //expands: true,
                textAlignVertical: TextAlignVertical.bottom,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: Color.fromRGBO(1, 170, 185, 1),
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
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(1, 170, 185, 1), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _inputText = text;
                  });
                },
                onTap: () {
                  setState(() {
                    _showEmojiKeyboard = false;
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });
                }
                ),
          )),
          ButtonTheme(
            minWidth: 10,
            child: RaisedButton(
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 25,
              ),
              color: _cleanText(_inputText).isNotEmpty
                  ? Color.fromRGBO(255, 202, 0, 1)
                  : Colors.grey[400],
              elevation: 1,
              padding:
                  EdgeInsets.only(left: 17, right: 14, top: 14, bottom: 14),
              shape: CircleBorder(),
              onPressed: () {
                String cleanedText = _cleanText(_inputText);
                if (cleanedText.isNotEmpty) {
                  var message = Message(
                      content: cleanedText,
                      createdAt: Timestamp.now(),
                      uid: widget.myUid);
                  setState(() {
                    _messages.add(message);
                    if (_scrollController.position.maxScrollExtent < 10000) {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    } else {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    }
                  });
                  ChatsService(myUid: widget.myUid)
                      .createMessage(widget.theirUid, message);
                  _textController.clear();
                }
              },
            ),
          )
        ]));
  }

  _buildMessage({String text, bool isMe}) {
    bool hasEmoji = EmojiParser().hasEmoji(text);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isMe
            ? EdgeInsets.only(top: 3, bottom: 3)
            : EdgeInsets.only(top: 4, bottom: 4),
        child: Material(
          elevation: hasEmoji ? 0 : 1,
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
                ? Color.fromRGBO(1, 170, 185, 1)
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
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      var msgUid = _messages[index].uid;
                      return _buildMessage(
                          text: _messages[index].content,
                          isMe: msgUid == widget.myUid);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              _buildMessageComposer(context, _textController),
              _buildEmojiPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
