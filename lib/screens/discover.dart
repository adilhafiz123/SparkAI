import 'package:Spark/models/userData.dart';
import 'package:Spark/screens/dismissible_profile.dart';
import 'package:Spark/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/screens/profile.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // //TODO: This UserProfile needs to be generated randomly from the DiscoveryEngine
    // UserData tempUserData1 = UserData(
    //     uid: "temp_uid",
    //     firstname: "Mawra",
    //     age: 27,
    //     height: Height(5, 6),
    //     imagepaths: ["images/mawra.jpg"],
    //     isBlurred: false,
    //     profession: "Actress",
    //     ethnicity: "Pakistani",
    //     language: "Urdu",
    //     drinks: false,
    //     gender: Gender.Female,
    //     halal: true,
    //     prayer: Prayer.Sometimes,
    //     religiousness: Religiousness.SomewhatPractising,
    //     modesty: Modesty.None,
    //     smokes: false,
    //     sect: Sect.Sunni,
    //     hobbies: List<String>());
    // UserData tempUserData2 = UserData(
    //     uid: "temp_uid",
    //     firstname: "Iqra",
    //     age: 27,
    //     height: Height(5, 6),
    //     imagepaths: ["images/iqra.png"],
    //     isBlurred: false,
    //     profession: "Actress",
    //     ethnicity: "Pakistani",
    //     language: "Urdu",
    //     drinks: Drinks.Never,
    //     gender: Gender.Female,
    //     halal: Halal.Always,
    //     prayer: Prayer.Usually,
    //     religiousness: Religiousness.SomewhatPractising,
    //     modesty: Modesty.None,
    //     smokes: Smokes.Never,
    //     sect: Sect.Sunni,
    //     hobbies: List<String>());

    List<Widget> widgetList = [
      Container(color: Theme.of(context).accentColor, child:Center(child: Icon(Icons.sentiment_dissatisfied, size: 150,),)),
      //DismissibleProfile(tempUserData1),
      //DismissibleProfile(tempUserData1),
      Positioned(
        bottom: 54,
        left: 260,
        child: buildButton("icons/heart.png"),
      ),
      Positioned(
        bottom: 54,
        right: 260,
        child: buildButton("icons/cross.png"),
      ),
    ];

    var actions = [
      PopupMenuButton<String>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onSelected: onSelected,
            itemBuilder: (BuildContext context) {
              var item1 = buildPopupMenuItem("Favourite", Icons.star);
              var item2 = buildPopupMenuItem("Block", Icons.block);
              var item3 = buildPopupMenuItem("Report", Icons.report);
              return [item1, item2, item3].toList();
            })];
    return Scaffold(
      appBar: buildAppBar("Discover", actions),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(5),
        child: Stack(
            alignment: AlignmentDirectional.topCenter, 
            children: widgetList),
      ),
    );
  }
}
