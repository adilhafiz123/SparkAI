import 'package:Spark/shared/enums.dart';

class Height {
  final int feet;
  final int inches;

  Height(this.feet, this.inches);

  @override
  String toString() {
    return feet.toString() + "' " + inches.toString() + "\"";
  }
}

class UserData {
  final String uid;
  final String firstname;
  final String lastname;
  final Gender gender;
  final int age;
  final Height height;
  final String profession;
  final String ethnicity;
  final String language;
  final String imagepath;
  final bool isBlurred;
  final Sect sect;
  final Religiousness religiousness;
  final Modesty modesty;
  final Prayer prayer;
  final Halal halal;
  final Drinks drinks;
  final Smokes smokes;
  final List<String> hobbies;

  UserData({
    this.uid, 
    this.firstname, 
    this.lastname, 
    this.age, 
    this.gender,
    this.height,
    this.profession, 
    this.ethnicity,
    this.language,
    this.imagepath = "images/mawra.jpg", //TODO: Should be the dafault male/female image
    this.isBlurred,
    this.sect,
    this.religiousness,
    this.modesty,
    this.prayer,
    this.halal,
    this.drinks,
    this.smokes,
    this.hobbies,
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