import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/userData.dart';

class DatabaseService {

  final String uid;
  final CollectionReference userCollection = Firestore.instance.collection("users");

  DatabaseService({ this.uid });

  Future updateUserData(String name, int age, String profession) async {
    return await userCollection.document(uid).setData({
      "first_name"       : name,
      "age"        : age,
      "profession" : profession
    });
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map( (doc) {
      return UserData(
        firstname:  doc.data["first_name"]        ?? "",
        age:        doc.data["age"]         ?? 0,
        profession: doc.data["profession"]  ?? "",
        );
    }).toList();

  }

  Stream<List<UserData>> get userStream {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  } 

}