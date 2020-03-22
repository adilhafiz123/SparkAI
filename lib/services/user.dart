import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/userData.dart';

class UserService {

  final String uid;
  final CollectionReference userCollection = Firestore.instance.collection("users");

  UserService({ this.uid });

  Future<UserData> getUserDocFutureFromUid(String uid) async {
    return userCollection.document(uid).get().then<UserData>( (DocumentSnapshot doc) {
      return UserData(
        firstname:  doc.data["first_name"]        ?? "",
        age:        doc.data["age"]         ?? 0,
        profession: doc.data["profession"]  ?? "",
        );
      } );
  }

  // DocumentSnapshot getChatDocFromUid(String uid) async {
  //   var doc = await getUserDocFutureFromUid(uid);
  //   return doc;
  //   if (doc.exists) {
  //     return UserData(
  //       firstname:  doc.data["first_name"]        ?? "",
  //       age:        doc.data["age"]         ?? 0,
  //       profession: doc.data["profession"]  ?? "",
  //       );
  //   }
  //   else {
  //     return UserData(age: 0, firstname: "", profession: "");
  //   }
  // }


  Future updateCurrentUserData(String name, int age, String profession) async {
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