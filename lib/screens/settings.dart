import 'dart:math';

import 'package:Spark/models/user.dart';
import 'package:Spark/screens/hobbies.dart';
import 'package:Spark/screens/photo_selector.dart';
import 'package:Spark/screens/photo_viewer.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Spark/screens/profile.dart';
import 'package:Spark/models/userData.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myUid = Provider.of<User>(context).uid;
    var _myUserData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: buildAppBar("Settings", List()),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text(
                  "Hobbies",
                  style: TextStyle(fontFamily: "Nunito", fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () async {
                  await Navigator.of(context)
                      .push<void>(MaterialPageRoute(builder: (_) => Hobbies()));
                }),
            RaisedButton(
                child: Text(
                  "My Profile",
                  style: TextStyle(fontFamily: "Nunito", fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () async {
                  await Navigator.of(context)
                      .push<void>(MaterialPageRoute<void>(builder: (_) {
                    return Profile(_myUserData);
                  }));
                }),
            RaisedButton(
                child: Text(
                  "Edit Pictures",
                  style: TextStyle(fontFamily: "Nunito", fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () async {
                  await Navigator.of(context)
                      .push<void>(MaterialPageRoute<void>(builder: (_) {
                    return PhotoSelector();
                  }));
                }),
          ],
        ),
      )),
    );
  }
}
