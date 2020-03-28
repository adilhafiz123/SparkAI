import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/chat.dart';

class ChatsService {
  final String myUid;
  final CollectionReference chatsCollection =
      Firestore.instance.collection("chats");

  ChatsService({this.myUid});

  Future<QuerySnapshot> getUsersChats() {
    return chatsCollection.where("uid1", isEqualTo: myUid).getDocuments();
  }

  createMessage(String theirUid, Message message) async {
    var messageMap = {
      "content"     : message.content,
      "created_at"  : message.createdAt,
      "uid"         : message.uid
      };
    var snapshot =
        await chatsCollection
        .where("uid2", isEqualTo: theirUid).getDocuments();
    if (snapshot.documents.length > 0) {
      snapshot.documents[0].reference
      .updateData({
        'messages' : FieldValue.arrayUnion([messageMap]),
        'count'    : FieldValue.increment(1),
        });
    }
  }
}
