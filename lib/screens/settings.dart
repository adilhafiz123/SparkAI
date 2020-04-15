import 'dart:math';

import 'package:Spark/models/user.dart';
import 'package:Spark/screens/hobbies.dart';
import 'package:Spark/screens/swipe_card.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Spark/screens/profile.dart';
import 'package:Spark/models/userData.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myUid = Provider.of<User>(context).uid;

    return Container(
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
                  return FutureBuilder<UserData>(
                      future: UserService(uid: myUid)
                          .getUserDocFutureFromUid(myUid),
                      builder: (_, userDataSnapshot) {
                        if (userDataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loading();
                        } else {
                          return Profile(userDataSnapshot.data);
                        }
                      });
                }));
              }),
          RaisedButton(
              child: Text(
                "TEST SWIPE",
                style: TextStyle(fontFamily: "Nunito", fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () async {
                await Navigator.of(context)
                    .push<void>(MaterialPageRoute<void>(builder: (_) {
                  return Stack(children: <Widget>[
                    SwipeCard(),
                  ]);
                }));
              }),
        ],
      ),
    ));
  }
}
