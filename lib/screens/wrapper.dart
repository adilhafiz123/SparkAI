import 'package:Spark/models/chat.dart';
import 'package:Spark/services/auth.dart';
import 'package:Spark/services/chats.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/screens/authenticate/authenticate.dart';
import 'package:Spark/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
