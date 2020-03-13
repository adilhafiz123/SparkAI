import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final image;
  final name;

  Profile({this.image, this.name}) {
    if (image == null || name == null) {
      AlertDialog(
        title: Text("Cant instantiate a ChatProfile without an Image and Name"),
      );
    }
  }
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(15),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  widget.image,
                ))),
        Center(
            child: Text(
          widget.name + ", 27",
          style: TextStyle(fontFamily: "Vidaloka", fontSize: 40),
        )),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              //SizedBox(width: 20),
              Chip(
                                elevation: 4,
                shadowColor: Colors.teal,
                labelPadding: EdgeInsets.all(5),
                avatar: Icon(Icons.grade, color: Colors.white),
                label: Text(
                  "5' 2\"",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
              //SizedBox(width: 20),
              Chip(
                                elevation: 4,
                shadowColor: Colors.teal,
                labelPadding: EdgeInsets.all(5),
                avatar: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                label: Text(
                  "London",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
              Chip(
                                elevation: 4,
                shadowColor: Colors.teal,
                labelPadding: EdgeInsets.all(5),
                avatar: Icon(Icons.person, color: Colors.white),
                label: Text(
                  "Single",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
              //SizedBox(width: 20),
              Chip(
                elevation: 4,
                shadowColor: Colors.teal,
                labelPadding: EdgeInsets.all(5),
                avatar: Icon(Icons.flag, color: Colors.white),
                label: Text(
                  "Pakistani",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
              Chip(
                                elevation: 4,
                shadowColor: Colors.teal,
                labelPadding: EdgeInsets.all(5),
                avatar: Icon(Icons.work, color: Colors.white),
                label: Text(
                  "Actress",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("Enter some profile info here. It can be a minimum of 80 characters to help weed out catfish and time waster types, \n\nEnter some profile info here. It can be a minimum of 80 characters to help weed out catfish and time waster typed",
          style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 20,
              fontWeight: FontWeight.w500),),
        )
      ],
    );
  }
}
