import 'package:Spark/models/userData.dart';
import 'package:Spark/screens/profile.dart';
import 'package:flutter/material.dart';

class DismissibleProfile extends StatelessWidget {
  final UserData _userData;

  DismissibleProfile(this._userData);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
            key: ValueKey(_userData.uid),
            crossAxisEndOffset: -0.3,
            onDismissed: (_) {
              // Do something
            },
            child: Profile(_userData)      
    );
  }
}