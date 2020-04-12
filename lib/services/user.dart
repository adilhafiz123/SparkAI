import 'package:Spark/shared/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/userData.dart';

class UserService {
  final String uid;
  final CollectionReference userCollection =
      Firestore.instance.collection("users");

  UserService({this.uid});

  Height _heightFromDb(String height) {
    if (height != null) {
      var heightBits = height.split(',');
      if (heightBits.length != 2) {
        throw Exception("Height stored in db is missing or not in the correct \"a,b\" format");
      }
      return Height(int.parse(heightBits[0]), int.parse(heightBits[1]));
    }
    return Height(0, 0);
  }

  UserData _buildUserDataFromDoc(DocumentSnapshot doc) {
      return UserData(
        uid: doc.documentID,
        firstname:      doc.data["first_name"] ?? "",
        lastname:       doc.data["last_name"] ?? "",
        age:            doc.data["age"] ?? 0,
        height:         _heightFromDb(doc.data["height"]),
        gender:         EnumHelper.GenderFromString(doc.data["gender"]),
        profession:     doc.data["profession"] ?? "",
        ethnicity:      doc.data["ethnicity"] ?? "",
        language:       doc.data["language"] ?? "",
        imagepath:      doc.data["image_path"] ?? "images/mawra.jpg", //TODO: This should be some generic default avater
        isBlurred:      doc.data["is_blurred"] ?? false,
        sect:           EnumHelper.SectFromString(doc.data["sect"]),
        religiousness:  EnumHelper.ReligiousnessFromString(doc.data["religiousness"]),
        modesty:        EnumHelper.ModestyFromString(doc.data["modesty"]),
        prayer:         EnumHelper.PrayerFromString(doc.data["prayer"]),
        halal:          EnumHelper.HalalFromString(doc.data["halal"]),
        drinks:         EnumHelper.DrinksFromString(doc.data["drinks"]),
        smokes:         EnumHelper.SmokesFromString(doc.data["smokes"]),
        hobbies:        doc.data["hobbies"] == null ? List<String>() :  List<String>.from(doc.data["hobbies"])
      );
  }

  Future<UserData> getUserDocFutureFromUid(String uid) async {
    return userCollection.document(uid).get().then<UserData>((DocumentSnapshot doc) {
          return _buildUserDataFromDoc(doc);
    });
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _buildUserDataFromDoc(doc);
    }).toList();
  }

  // TODO: THIS NEEDS TO BE UPDATED 
  // (this method should only be called after the full signup proces (which feeds through a UserData))
  Future updateCurrentUserData(UserData userData) async {
    return await userCollection
        .document(uid)
        .updateData({
          "first_name":   userData.firstname,
          "age":          userData.age,
          "profession":   userData.profession
          });
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

  Future<bool> updateHobbies(List<String> hobbies) async {
    return Future<bool>(() {
      return userCollection
          .document(uid)
          .updateData({"hobbies": hobbies}).then((_) {
        return true;
      });
    });
  }
}
