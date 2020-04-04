import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  /// The content of the message
  String content;

  /// Firestore timestamp of when the message was created
  Timestamp createdAt;

  /// The UID of the User who created the message
  String userUid;

  /// The UID of the message
  String messageUid;

  Message({this.content, this.createdAt, this.userUid, this.messageUid}) {
    if (messageUid == null) {
      this.messageUid = Uuid().v1();
    }
  }
}

class Chat {
  String uid1;
  String uid2;
  int count;
  List<Message> messages;

  Chat(this.uid1, this.uid2, this.count, this.messages);
}

class Uid1Chat extends Chat {
  Uid1Chat({uid1, uid2, count, messages}) : super(uid1, uid2, count, messages);
}

class Uid2Chat extends Chat {
  Uid2Chat({uid1, uid2, count, messages}) : super(uid1, uid2, count, messages);
}
