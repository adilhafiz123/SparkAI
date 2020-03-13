import 'package:flutter/material.dart';
import 'package:hello_fluter/models/user.dart';
import 'package:hello_fluter/screens/authenticate/authenticate.dart';
import 'package:hello_fluter/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}