import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsService {
  final String myUid;
  final CollectionReference chatsCollection =
      Firestore.instance.collection("chats");

  ChatsService({this.myUid});

  Future<QuerySnapshot> getUsersChats() {
    return chatsCollection
    .where("uid1", isEqualTo: myUid)
    .getDocuments();
  }

}
