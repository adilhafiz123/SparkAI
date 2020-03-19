import 'package:flutter/material.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:Spark/shared/profile.dart';

class DiscoverView extends StatelessWidget {
  buildButton(String imagePath) {
    return Container(
      height: 70,
      //constraints: BoxConstraints.expand(height: 20),
      child: RaisedButton(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          ),
        ),
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDiscoverAppBar(),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(5),
        child:
            Stack(alignment: AlignmentDirectional.bottomEnd, children: <Widget>[
          Profile(),
          Positioned(
            bottom: 54,
            left: 260,
            child: buildButton("icons/heart.png"),
          ),          
          Positioned(
            bottom: 54,
            right: 260,
            child: buildButton("icons/cross.png"),
          )
        ]),
      ),
    );
  }
}
