import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String content;
  Timestamp createdAt;
  String uid;

  Message( {this.content, this.createdAt, this.uid} );
}

class Chat {
  String uid1;
  String uid2;
  int count;
  List<Message> messages;

  Chat({ this.uid1, this.uid2, this.count, this.messages });
}