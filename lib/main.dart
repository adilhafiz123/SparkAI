import 'package:flutter/material.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/screens/messages.dart';
import 'package:Spark/screens/wrapper.dart';
import 'package:Spark/services/auth.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';

void main() => runApp(new Spark());

class Spark extends StatefulWidget {
  @override
  _SparkState createState() => _SparkState();
}

class _SparkState extends State<Spark> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: "Spark!",
          debugShowCheckedModeBanner: false,
          home: Wrapper()),
    );
  }
}
