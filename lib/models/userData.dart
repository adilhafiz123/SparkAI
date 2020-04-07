import 'package:Spark/shared/enums.dart';

class UserData {
  final String uid;
  final String firstname;
  final String lastname;
  final int age;
  final Gender gender;
  final String profession;
  final String imagepath;
  final Sect sect;
  final Religiousness religiousness;
  final Modesty modesty;
  final Prayer prayer;
  final Halal halal;
  final Drinks drinks;
  final Smokes smokes;

  UserData({
    this.uid, 
    this.firstname, 
    this.lastname, 
    this.age, 
    this.gender,
    this.profession, 
    this.imagepath = "images/mawra.jpg", //TODO: Should be the dafault male/female image
    this.sect,
    this.religiousness,
    this.modesty,
    this.prayer,
    this.halal,
    this.drinks,
    this.smokes
  });

  String getPractisingLevel() {
    if (this.religiousness != null) {
      switch(this.religiousness) {
        case Religiousness.VeryPractising:
          return "Very Practising";
        case Religiousness.Practising:
          return "Practising";
        case Religiousness.SomewhatPractising:
          return "Somewhat Practising";
        case Religiousness.NotPractising:
          return "Not Practising";
      }
    }
    return "";
  }
}