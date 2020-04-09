import 'package:Spark/shared/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/userData.dart';

class UserService {
  final String uid;
  final CollectionReference userCollection =
      Firestore.instance.collection("users");

  UserService({this.uid});

  Future<UserData> getUserDocFutureFromUid(String uid) async {
    return userCollection
        .document(uid)
        .get()
        .then<UserData>((DocumentSnapshot doc) {
      return UserData(
        uid:              doc.documentID,
        firstname:        doc.data["first_name"] ?? "",
        lastname:         doc.data["last_name"] ?? "",
        age:              doc.data["age"] ?? 0,
        gender:           EnumHelper.GenderFromString(doc.data["gender"]),
        profession:       doc.data["profession"] ?? "",
        imagepath:        doc.data["image_path"] ?? "images/mawra.jpg",//TODO: This should be some generic default avater
        sect:             EnumHelper.SectFromString(doc.data["sect"]),
        religiousness:    EnumHelper.ReligiousnessFromString(doc.data["religiousness"]),
        modesty:          EnumHelper.ModestyFromString(doc.data["modesty"]),
        prayer:           EnumHelper.PrayerFromString(doc.data["prayer"]),
        halal:            EnumHelper.HalalFromString(doc.data["halal"]),
        drinks:           EnumHelper.DrinksFromString(doc.data["drinks"]),
        smokes:           EnumHelper.SmokesFromString(doc.data["smokes"]),
      );
    });
  }

  Future updateCurrentUserData(String name, int age, String profession) async {
    return await userCollection
        .document(uid)
        .setData({"first_name": name, "age": age, "profession": profession});
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        uid:              doc.documentID,
        firstname:        doc.data["first_name"] ?? "",
        lastname:         doc.data["last_name"] ?? "",
        age:              doc.data["age"] ?? 0,
        gender:           EnumHelper.GenderFromString(doc.data["gender"]),
        profession:       doc.data["profession"] ?? "",
        imagepath:        doc.data["image_path"] ?? "images/mawra.jpg",//TODO: This should be some generic default avater
        sect:             EnumHelper.SectFromString(doc.data["sect"]),
        religiousness:    EnumHelper.ReligiousnessFromString(doc.data["religiousness"]),
        modesty:          EnumHelper.ModestyFromString(doc.data["modesty"]),
        prayer:           EnumHelper.PrayerFromString(doc.data["prayer"]),
        halal:            EnumHelper.HalalFromString(doc.data["halal"]),
        drinks:           EnumHelper.DrinksFromString(doc.data["drinks"]),
        smokes:           EnumHelper.SmokesFromString(doc.data["smokes"]),
      );
    }).toList();
  }

  Stream<List<UserData>> get userStream {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  }

  Future<List<String>> getHobbies(String uid) {
    return userCollection
        .document(uid)
        .get()
        .then<List<String>>((DocumentSnapshot doc) {
      return List<String>.from(doc.data["hobbies"]);
    });
  }

}