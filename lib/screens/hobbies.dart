import 'package:Spark/models/user.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hobbies extends StatefulWidget {
  final hobbies = [
    "Art",
    "Baking",
    "Beauty",
    "Board Games",
    "Boxing",
    "Calligraphy",
    "Coding",
    "Cooking",
    "Cricket",
    "Dance",
    "Eating Out",
    "Fitness",
    "Football",
    "Gardening",
    "Guitar",
    "Hiking",
    "Islam",
    "Languages",
    // "Martial Arts",
    // "Meditation",
    // "Music",
    // "Nature",
    // "Netflix",
    // "Photography",
    // "Piano",
    // "Pool & Snooker",
    // "Quran",
    // "Racquet Sports",
    // "Reading",
    // "Running",
    // "Shopping",
    // "Sleeping",
    // "Spirituality",
    // "Sports",
    // "Swimming",
    // "Technology",
    // "Theatre",
    // "Travelling",
    // "Video Games",
    // "Walking",
    // "Writing",
    // "Yoga",
  ];
  @override
  _HobbiesState createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  var _selectedHobbies = List<String>();
  var _firstLoadDone = false;

  _getImage(String hobby) {
    var filePath = "icons/" + hobby.toLowerCase().replaceAll(" ", "_") + ".png";
    var image;
    try {
      image = Image.asset(
        filePath,
        height: 40,
      );
    } catch (_) {
      image = Image.asset("icons/photography.png");
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: image,
    );
  }

  Widget _buildCheckListTile(BuildContext context, int index) {
    var hobby = widget.hobbies[index];
    return CheckboxListTile(
        value: _selectedHobbies.contains(hobby),
        secondary: _getImage(hobby),
        title: Text(hobby,
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        activeColor: Color.fromRGBO(1, 170, 185, 1),
        onChanged: (checked) {
          if (checked) {
            _selectedHobbies.add(hobby);
          } else {
            _selectedHobbies.remove(hobby);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final myUid = Provider.of<User>(context).uid;
    UserService().getHobbies(myUid).then<List<String>>((selectedHobbies) {
      setState(() {
        if (!_firstLoadDone) {
          _selectedHobbies = selectedHobbies;
          _firstLoadDone = true;
        }
      });
    });
    return Scaffold(
      appBar: buildHobbiesAppBar(),
      body: Column(
        children: <Widget>[
          Text("Choose up to 6 hobbies",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          Expanded(
            child: ListView.builder(
              itemCount: widget.hobbies.length,
              itemBuilder: _buildCheckListTile,
            ),
          )
        ],
      ),
    );
  }
}
