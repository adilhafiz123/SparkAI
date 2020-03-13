import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_fluter/models/userData.dart';

class DatabaseService {

  final String uid;
  final CollectionReference userCollection = Firestore.instance.collection("users");

  DatabaseService({ this.uid });

  Future updateUserData(String name, int age, String profession, List<String> chats) async {
    return await userCollection.document(uid).setData({
      "name"       : name,
      "age"        : age,
      "profession" : profession,
      "chats"      : chats   
    });
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map( (doc) {
      return UserData(
        firstname: doc.data["name"] ?? "",
        age: doc.data["age"] ?? 0,
        );
    }).toList();

  }

  Stream<List<UserData>> get userStream {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  } 

}