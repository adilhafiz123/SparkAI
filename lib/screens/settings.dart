import 'package:Spark/screens/hobbies.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: RaisedButton(
          child: Text(
            "Hobbies",
            style: TextStyle(fontFamily: "Nunito", fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () async {
            var selectedHobbies = await Navigator.of(context).push<List<String>>(MaterialPageRoute<List<String>>(builder: (_) => Hobbies()));
            var removeMe = selectedHobbies;
          }),
    ));
  }
}
