import 'package:flutter/material.dart';
import 'package:Spark/models/userData.dart';

class Profile extends StatefulWidget {
  final UserData userData;

  Profile(this.userData);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Widget buildDiscoverPhoto(String photoPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        photoPath,
        height: 420,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildChip(String label, IconData iconData, Color color) {
    return Chip(
      elevation: 3,
      shadowColor: color,
      label: Text(label,
          style: TextStyle(
              fontSize: 14, fontFamily: "Nunito", fontWeight: FontWeight.w600,color: Colors.white)),
      avatar: Icon(
        iconData,
        size: 18,
        color: Colors.white,
      ),
      backgroundColor: color,
      padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
    );
  }

  Widget buildProfileText(String name, int age) {
    return Container(
      //color: Colors.blueGrey[100],
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name + ", ",
                style: TextStyle(fontSize: 35, fontFamily: "vidaloka")),
            Text(age.toString(),
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "vidaloka",
                    color: Colors.grey[700]))
          ],
        ),
        Text("24 miles away, Slough",
            style: TextStyle(
                fontSize: 15, fontFamily: "Nunito", fontWeight: FontWeight.w800)),
        Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: <Widget>[
            buildChip("Actress", Icons.work, Colors.teal),
            buildChip("Pakistani", Icons.flag, Color.fromARGB(255, 245, 183, 1)),
            buildChip("United Kingdom", Icons.flag, Colors.blue[800]),
          ],
        ),
        SizedBox(height: 14,),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area,\n\n This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area, \n\n This is the main profile area, this is the main profile area, this is the main profile area, this is the main profile area,",
          style: TextStyle(
                  fontSize: 18, fontFamily: "Nunito", fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
        //   Hero(
        //     tag: "Avatar",
            /*child:*/ buildDiscoverPhoto(widget.userData.imagepath),
          // ),
          buildProfileText(widget.userData.firstname, widget.userData.age),
        ],
      );
  }
}
