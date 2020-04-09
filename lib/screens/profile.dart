import 'package:flutter/material.dart';
import 'package:Spark/models/userData.dart';

class Profile extends StatefulWidget {
  final UserData userData;

  Profile(this.userData);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          widget.userData.imagepath,
          height: 420,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIntro() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.userData.firstname + ", ",
                style: TextStyle(fontSize: 35, fontFamily: "vidaloka")),
            Text(widget.userData.age.toString(),
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "vidaloka",
                    color: Colors.grey[700]))
          ],
        ),
        Text("24 miles away, Slough",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w800)),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildChip(String label, String imagePath, Color backColor, Color textColor) {
    return Chip(
      elevation: 3,
      //shadowColor: backColor,
      label: Padding(
        padding: const EdgeInsets.only(left:0, right:0, top:3, bottom:3),
        child: Text(label,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: textColor)),
      ),
      avatar: Padding(
        padding: const EdgeInsets.only(left:1, right:0, top:3, bottom:3),
        child: Image.asset(imagePath),
      ),
      backgroundColor: backColor,
      padding: EdgeInsets.only(left: 7, right: 8, top: 1, bottom: 1),
    );
  }

  Widget buildBasicsChipCollection() {
    var textColor = Colors.white;
    var backColor = Color.fromRGBO(1, 170, 185, 1);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildChip(widget.userData.profession, "icons/laptop.png", backColor, textColor),
          buildChip("5' 11\"", "icons/double-arrow.png", backColor, textColor),
          buildChip("Pakistani", "icons/pakistan.png", backColor, textColor),
          buildChip("Urdu", "icons/language.png", backColor, textColor),
        ],
      ),
    );
  }

  Widget buildReligionChipCollection() {
    var textColor = Color.fromRGBO(0, 19, 91, 1);
    var backColor = Color.fromRGBO(255, 202, 0, 1);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildChip(widget.userData.sect.toString().split('.').last, "icons/islam.png", backColor, textColor),
          buildChip(widget.userData.getPractisingLevel(), "icons/beads.png", backColor, textColor),
          buildChip(widget.userData.modesty.toString().split('.').last, "icons/hijab.png", backColor, textColor),
          buildChip(widget.userData.prayer.toString().split('.').last, "icons/pray2.png", backColor, textColor),
          buildChip(widget.userData.halal.toString().split('.').last, "icons/halal.png", backColor, textColor),
          buildChip(widget.userData.drinks.toString().split('.').last, "icons/wine.png", backColor, textColor),
          buildChip(widget.userData.smokes.toString().split('.').last, "icons/smoke.png", backColor, textColor),
        ],
      ),
    );
  }

  Widget buildHobbiesChipCollection() {
    var textColor = Colors.black;
    var backColor = Colors.white;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildChip("Photography", "icons/photography.png", backColor, textColor),
          buildChip("Exercise", "icons/gym.png", backColor, textColor),
          buildChip("Cooking", "icons/cooking.png", backColor, textColor),
          buildChip("Reading", "icons/book.png", backColor, textColor),
        ],
      ),
    );
  }


  Widget buildProfileText() {
    return Container(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
              "This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area,\n\n This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area, \n\n This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area,",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildPhoto(),
        buildIntro(),
        buildBasicsChipCollection(),
        Divider(),
        buildReligionChipCollection(),
        Divider(),
        buildHobbiesChipCollection(),
        Divider(),
        buildProfileText(),
      ],
    );
  }
}
