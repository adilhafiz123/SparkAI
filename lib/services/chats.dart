import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/chat.dart';

class ChatsService {
  final String myUid;
  final CollectionReference chatsCollection =
      Firestore.instance.collection("chats");

  ChatsService({this.myUid});

  List<Message> _messageListFromDynamicList(List<dynamic> chatData) {
    return chatData.map((map) {
      return Message(
        content:      map["content"] ?? "",
        createdAt:    map["created_at"] ?? Timestamp.now(),
        userUid:      map["user_uid"] ?? "",
        messageUid:   map["message_uid"] ?? "",
      );
    }).toList();
  }

  List<Chat> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map( (doc) {
      return Chat(
        doc.data["uid1"] ?? "",
        doc.data["uid2"] ?? "",
        doc.data["count"] ?? 0,
        _messageListFromDynamicList(doc.data["messages"]),
      );
    }).toList();
  }

  List<Uid1Chat> _uid1chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Uid1Chat(
        uid1: doc.data["uid1"] ?? "",
        uid2: doc.data["uid2"] ?? "",
        count: doc.data["count"] ?? 0,
        messages: _messageListFromDynamicList(doc.data["messages"]),
      );
    }).toList();
  }

  List<Uid2Chat> _uid2ChatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Uid2Chat(
        uid1: doc.data["uid1"] ?? "",
        uid2: doc.data["uid2"] ?? "",
        count: doc.data["count"] ?? 0,
        messages: _messageListFromDynamicList(doc.data["messages"]),
      );
    }).toList();
  }

  Stream<List<Uid1Chat>> get getUID1Chats {
    return chatsCollection
        .where("uid1", isEqualTo: myUid)
        .snapshots()
        .map(_uid1chatListFromSnapshot);
  }

  Stream<List<Uid2Chat>> get getUID2Chats {
    return chatsCollection
        .where("uid2", isEqualTo: myUid)
        .snapshots()
        .map(_uid2ChatListFromSnapshot);
  }

  Stream<List<Chat>> getChatForUid1Uid2 (String uid1, String uid2) {
    // chat_uid in the database is always stored in lexical order
    var chatUid = uid1.compareTo(uid2) == -1 ? uid1 + "," + uid2 : uid2 +  "," + uid1;
    return chatsCollection
        .where("chat_id", isEqualTo: chatUid)
        .snapshots()
        .map(_chatListFromSnapshot);
  }

  updateChat(String uid1, String uid2, Message message) async {
    var messageMap = {
      "content": message.content,
      "created_at": message.createdAt,
      "user_uid": message.userUid,
      "message_uid": message.messageUid,
    };
    var snapshot = await chatsCollection
        .where("uid1", isEqualTo: uid1)
        .where("uid2", isEqualTo: uid2)
        .getDocuments();
    if (snapshot.documents.length > 0) {
      snapshot.documents[0].reference.updateData({
        'messages': FieldValue.arrayUnion([messageMap]),
        'count': FieldValue.increment(1),
      });
    }
  }

  createMessage(String theirUid, Message message) async {
    // MyUid-TheirUid can be saved in either direction
    updateChat(myUid, theirUid, message);
    updateChat(theirUid, myUid, message);
  }

  deleteMessage(Message message) async {
    var messageToDelete = {
      "content": message.content,
      "created_at": message.createdAt,
      "user_uid": message.userUid,
      "message_uid": message.messageUid,
    };
    var snapshot = await chatsCollection
        .where("messages", arrayContains: messageToDelete)
        .getDocuments();
    if (snapshot.documents.length > 0) {
      snapshot.documents[0].reference.updateData({
        'messages': FieldValue.arrayRemove([messageToDelete]),
        'count': FieldValue.increment(-1),
      });
    } else {
      throw Exception(
          "Tried to delete a message to a chat which does not exist in the database");
    }
  }
}
