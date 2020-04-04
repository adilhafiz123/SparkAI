import 'package:Spark/models/chat.dart';
import 'package:Spark/screens/chat_profile.dart';
import 'package:Spark/services/chats.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/screens/messages.dart';
import 'package:Spark/screens/wrapper.dart';
import 'package:Spark/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(new Spark());

class Spark extends StatefulWidget {
  @override
  _SparkState createState() => _SparkState();
}

class _SparkState extends State<Spark> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (context) => AuthService().user,
      child: MaterialApp(
        title: "Spark!",
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          "/chat_profile": (context) => ChatProfile(),
        },
      ),
    );
  }
}
