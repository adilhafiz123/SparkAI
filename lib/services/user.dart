import 'package:Spark/shared/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Spark/models/userData.dart';
import 'package:enum_to_string/enum_to_string.dart';

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
      try {
      return UserData(
        uid: doc.documentID,
        firstname:        doc.data["first_name"] ?? "",
        lastname:         doc.data["last_name"] ?? "",
        age:              doc.data["age"] ?? 0,
        height:           _heightFromDb(doc.data["height"]),
        gender:           EnumToString.fromString([Gender.Male, Gender.Female], doc.data["gender"]),
        profession:       doc.data["profession"] ?? "",
        ethnicity:        doc.data["ethnicity"] ?? "",
        language:         doc.data["language"] ?? "",
        isBlurred:        doc.data["is_blurred"] ?? false,
        sect:             EnumToString.fromString([Sect.Sunni, Sect.Shia, Sect.Other],doc.data["sect"]),
        religiousness:    EnumToString.fromString([
                            Religiousness.VeryPractising, 
                            Religiousness.Practising,
                            Religiousness.SomewhatPractising, 
                            Religiousness.NotPractising], doc.data["religiousness"]),
        modesty:          EnumToString.fromString([Modesty.Hijab, Modesty.Modest, Modesty.None], doc.data["modesty"]),
        prayer:           EnumToString.fromString([
                            Prayer.Always,
                            Prayer.Usually,
                            Prayer.Sometimes,
                            Prayer.Never], doc.data["prayer"]),
        halal:            doc.data["halal"] ?? true,
        drinks:           doc.data["drinks"] ?? false,
        smokes:           doc.data["smokes"] ?? false,
        imageNameUrlMap:  doc.data["image_urls"] == null ? Map<String,String>() :  Map<String,String>.from(doc.data["image_url_map"]),
        hobbies:          doc.data["hobbies"] == null ? List<String>() :  List<String>.from(doc.data["hobbies"])
      );
      }
      catch(e) {
        throw Exception("Could not construct UserData object from Snapshot " + e.toString());
      }
  }


  Future updateCurrentUserData(UserData userData) async {
    return await userCollection
        .document(uid)
        .updateData({
            "first_name":      userData.firstname,
            "last_name":       userData.lastname,
            "age":             userData.age,
            "height":          userData.height.toString(),
            "gender":          EnumToString.parseCamelCase(userData.gender),
            "profession":      userData.profession.toString(),
            "ethnicity":       userData.ethnicity.toString(),
            "language":        userData.language.toString(),
            "isBlurred":       userData.isBlurred.toString(),
            "sect":            EnumToString.parseCamelCase(userData.sect),
            "religiousness":   EnumToString.parseCamelCase(userData.religiousness),
            "modesty":         EnumToString.parseCamelCase(userData.modesty),
            "prayer":          EnumToString.parseCamelCase(userData.prayer),
            "halal":           EnumToString.parseCamelCase(userData.halal),
            "drinks":          EnumToString.parseCamelCase(userData.drinks),
            "smokes":          EnumToString.parseCamelCase(userData.smokes),
            "image_url_map":   userData.imageNameUrlMap,
            "hobbies":         userData.hobbies,
          });
  }

  Future<UserData> getUserDocFutureFromUid(String uid) async {
    return userCollection.document(uid).get().then<UserData>((DocumentSnapshot doc) {
          return _buildUserDataFromDoc(doc);
    });
  }

  // List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return _buildUserDataFromDoc(doc);
  //   }).toList();
  // }

  // Stream<List<UserData>> get userStream {
  //   return userCollection.snapshots().map(_userDataListFromSnapshot);
  // }

  Stream<UserData> myUserStream(String myUid) {
    return userCollection.document(myUid).snapshots().map(_buildUserDataFromDoc);
  }

  Future<List<String>> getHobbies(String uid) {
    return userCollection
        .document(uid)
        .get()
        .then<List<String>>((DocumentSnapshot doc) {
          if (doc != null) {
            return List<String>.from(doc.data["hobbies"]);
          }
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

    Future<Map<String,String>> getImageUrls(String myUid) {
    return userCollection.document(uid).get()
            .then<Map<String,String>>((DocumentSnapshot doc) {
              if (doc != null && doc.data != null) {
                return Map<String,String>.from(doc.data["image_urls"]);
              }
            });
  }

  Future<bool> updateImageNameUrlMap(Map<String,String> images) async {
    return Future<bool>(() {
      return userCollection
          .document(uid)
          .updateData({"image_urls": images}).then((_) {
        return true;
      });
    });
  }
}
