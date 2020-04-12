import 'package:Spark/models/userData.dart';
import 'package:Spark/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/screens/profile.dart';

class DiscoverView extends StatelessWidget {
  
  buildButton(String imagePath) {
    return Container(
      height: 70,
      child: RaisedButton(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          ),
        ),
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO: This UserProfile needs to be generated randomly from the DiscoveryEngine
    UserData tempUserData = UserData(
      uid: "temp_uid", 
      firstname: "Mawra", 
      age: 27, 
      height: Height(5, 6),
      imagepath: "images/mawra.jpg",
      isBlurred: false, 
      profession: "Actress",
      ethnicity: "Pakistani",
      language: "Urdu",
      drinks: Drinks.Never,
      gender: Gender.Female,
      halal: Halal.Always,
      prayer: Prayer.Sometimes,
      religiousness: Religiousness.SomewhatPractising,
      modesty: Modesty.None,
      smokes: Smokes.Never,
      sect: Sect.Sunni,
      hobbies: List<String>());
    return Scaffold(
      appBar: buildDiscoverAppBar(),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(5),
        child:
            Stack(alignment: AlignmentDirectional.bottomEnd, children: <Widget>[
          Profile(tempUserData),
          Positioned(
            bottom: 54,
            left: 260,
            child: buildButton("icons/heart.png"),
          ),          
          Positioned(
            bottom: 54,
            right: 260,
            child: buildButton("icons/cross.png"),
          )
        ]),
      ),
    );
  }
}
