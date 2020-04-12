import 'package:Spark/models/user.dart';
import 'package:Spark/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Spark/shared/helper.dart';

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
    "Current Affairs",
    "Dance",
    "DIY",
    "Eating Out",
    "Fitness",
    "Football",
    "Gardening",
    "Guitar",
    "Hiking",
    "Islam",
    "Languages",
    "Martial Arts",
    "Meditation",
    "Music",
    "Nature",
    "Netflix",
    "Photography",
    "Piano",
    "Pool & Snooker",
    "Quran",
    "Racquet Sports",
    "Reading",
    "Running",
    "Shopping",
    "Sleeping",
    "Swimming",
    "Technology",
    "Theatre",
    "Travelling",
    "Video Games",
    "Writing",
    "Yoga",
  ];


  @override
  _HobbiesState createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  var _selectedHobbies = List<String>();
  var _firstLoadDone = false;

  Widget buildHobbiesAppBar(myUid) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey),
      titleSpacing: 60,
      title: Text(
        "Hobbies",
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: "vidaloka",
          fontSize: 28,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }


  Widget _buildCheckListTile(BuildContext context, int index) {
    var hobby = widget.hobbies[index];
    return CheckboxListTile(
        value: _selectedHobbies.contains(hobby),
        secondary: Padding(
                    child: Helper.getImage(hobby),
                    padding: EdgeInsets.all(10),
                    ),
        dense: true,
        title: Text(
          hobby,
          style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        activeColor: Color.fromRGBO(1, 170, 185, 1),
        onChanged: (checked) {
          if (checked) {
            if (_selectedHobbies.length < 6) {
              _selectedHobbies.add(hobby);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Only 6 hobbies allowed!"),
                duration: Duration(seconds: 2),
              ));
            }
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
    return WillPopScope(
      onWillPop: () {
        return UserService(uid: myUid).updateHobbies(_selectedHobbies);
      },
      child: Scaffold(
        appBar: buildHobbiesAppBar(myUid),
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Choose up to 6 hobbies",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.hobbies.length,
                  itemBuilder: _buildCheckListTile,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
