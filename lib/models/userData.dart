import 'package:Spark/shared/enums.dart';

class Height {
  final int feet;
  final int inches;

  Height(this.feet, this.inches);

  @override
  String toString() {
    return feet.toString() + "," + inches.toString();
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
  bool isBlurred;
  final Sect sect;
  final Religiousness religiousness;
  final Modesty modesty;
  final Prayer prayer;
  final bool halal;
  final bool drinks;
  final bool smokes;
  final Map<String,String> imageNameUrlMap;
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
    this.isBlurred,
    this.sect,
    this.religiousness,
    this.modesty,
    this.prayer,
    this.halal,
    this.drinks,
    this.smokes,
    this.imageNameUrlMap,
    this.hobbies,
  });

  getMainImage() {
    return this.imageNameUrlMap[this.uid + "/" + "0.jpg"] ?? "images/mawra/jpg"; //Todo:Replace this with default avatar
  }

}