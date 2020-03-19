import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsService {
  final String myUid;
  final CollectionReference chatsCollection =
      Firestore.instance.collection("chats");

  ChatsService({this.myUid});

  Future<QuerySnapshot> getUsersChat() {
    return chatsCollection
    .where(myUid, whereIn: ["uid1", "uid2"])
    .getDocuments();
  }

}
