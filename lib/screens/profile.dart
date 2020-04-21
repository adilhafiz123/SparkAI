import 'dart:ui';
import 'package:Spark/screens/photo_viewer.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/userData.dart';
import 'package:Spark/shared/helper.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final UserData userData;

  Profile(this.userData);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  buildHeadline(context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Text(
        "Not all those who wander are lost...",
        textAlign: TextAlign.center,
        style: GoogleFonts.pacifico(
            fontSize: 18,
            color: Colors.white, //Theme.of(context).accentColor,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ]),
      ),
    );
  }

  Widget buildPhoto() {
    var sigma = widget.userData != null ? (widget.userData.isBlurred ? 5.0 : 0.0) : 0.0;
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.userData.getMainImage(),
              height: 420,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                  builder: (context) {
                    return PhotoViewer(widget.userData.imageNameUrlMap);
                  }
              )
            );
          },
        ),
      ),
      Positioned.fill(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ))
    ]);
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

  Widget buildChipByPath(
      String label, String imagePath, Color backColor, Color textColor) {
    return buildChip(label, Image.asset(imagePath), backColor, textColor);
  }

  Widget buildChip(
      String label, Image image, Color backColor, Color textColor) {
    return Chip(
      elevation: 2,
      //shadowColor: backColor,
      label: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 3),
        child: Text(label,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: textColor)),
      ),
      avatar: Padding(
        padding: const EdgeInsets.only(left: 1, right: 0, top: 3, bottom: 3),
        child: image,
      ),
      backgroundColor: backColor,
      padding: EdgeInsets.only(left: 7, right: 8, top: 1, bottom: 1),
    );
  }

  Widget buildBasicsChipCollection() {
    var textColor = Colors.white;
    var backColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildChipByPath(widget.userData.profession, "icons/laptop.png",
              backColor, textColor),
          buildChipByPath(widget.userData.height.toString(),
              "icons/double-arrow.png", backColor, textColor),
          buildChip(widget.userData.ethnicity,
              Helper.getImage(widget.userData.ethnicity), backColor, textColor),
          buildChipByPath("Urdu", "icons/language.png", backColor, textColor),
        ],
      ),
    );
  }

  Widget buildReligionChipCollection() {
    var textColor = Colors.black;
    var backColor = Theme.of(context).accentColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          buildChipByPath(widget.userData.sect.toString().split('.').last,
              "icons/islam.png", backColor, textColor),
          buildChipByPath(EnumToString.parseCamelCase(widget.userData.religiousness),
              "icons/beads.png", backColor, textColor),
          buildChipByPath(widget.userData.modesty.toString().split('.').last,
              "icons/hijab.png", backColor, textColor),
          buildChipByPath(widget.userData.prayer.toString().split('.').last,
              "icons/pray2.png", backColor, textColor),
          buildChipByPath(widget.userData.halal.toString().split('.').last,
              "icons/halal.png", backColor, textColor),
          buildChipByPath(widget.userData.drinks.toString().split('.').last,
              "icons/wine.png", backColor, textColor),
          buildChipByPath(widget.userData.smokes.toString().split('.').last,
              "icons/smoke.png", backColor, textColor),
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
          children: widget.userData.hobbies == null
              ? List()
              : widget.userData.hobbies.map((hobby) {
                  Image image = Helper.getImage(hobby);
                  return buildChip(hobby, image, backColor, textColor);
                }).toList()),
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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(alignment: Alignment.topCenter, children: <Widget>[
            buildPhoto(),
            buildHeadline(context),
          ]),
          buildIntro(),
          buildBasicsChipCollection(),
          Divider(),
          buildReligionChipCollection(),
          if (widget.userData.hobbies.length > 0) Divider(),
          if (widget.userData.hobbies.length > 0) buildHobbiesChipCollection(),
          Divider(),
          buildProfileText(),
        ],
      ),
    );
  }
}
