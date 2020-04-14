import 'dart:ui';

import 'package:Spark/services/chats.dart';
import 'package:flutter/material.dart';

PopupMenuItem<String> buildPopupMenuItem(String label, IconData iconData) {
  return PopupMenuItem<String>(
      value: label,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(label),
      ));
}

void onSelected(String choice) {}

Widget buildDiscoverAppBar() {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey),
    titleSpacing: 60,
    title: Text(
      "Discover",
      style: TextStyle(
        color: Colors.grey[700],
        fontFamily: "vidaloka",
        fontSize: 28,
      ),
    ),
    backgroundColor: Colors.white,
    leading: Image(
      image: AssetImage("images/sparks.png"),
      color: Colors.grey,
    ),
    actions: <Widget>[
      PopupMenuButton<String>(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            var item1 = buildPopupMenuItem("Favourite", Icons.star);
            var item2 = buildPopupMenuItem("Block", Icons.block);
            var item3 = buildPopupMenuItem("Report", Icons.report);
            return [item1, item2, item3].toList();
          }),
    ],
  );
}

Widget buildMessagesAppBar() {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.grey),
    titleSpacing: 60,
    title: Text(
      "Messages",
      style: TextStyle(
        color: Colors.grey[700],
        fontFamily: "vidaloka",
        fontSize: 28,
      ),
    ),
    backgroundColor: Colors.white,
    leading: Image(
      image: AssetImage("images/sparks.png"),
      color: Colors.grey,
    ),
  );
}


Widget buildChatProfileAppBar(String name, String imagePath, bool isBlurred, BuildContext context) {
  var sigma = isBlurred ? 5.0 : 0.0;
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleSpacing: 60,
    leading: IconButton(
      iconSize: 5,
      icon: Image.asset(
              "icons/back_arrow.png",
              height: 25,
              color: Colors.grey,
            ), 
      onPressed: () => Navigator.of(context).pop()
    ), 
    title: Row(children: <Widget>[
      Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(imagePath,),
          ),
            ClipOval(  // <-- clips to the child Containers dimensions
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX:sigma, sigmaY: sigma),
                child: Container(
                  alignment: Alignment.center,
                  width: 40.0,
                  height: 40.0,
                  child: Text(" "),
                ),
              ),
            ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Text(name,
          style: TextStyle(
        color: Colors.grey[700],
        fontFamily: "vidaloka",
        fontSize: 28,
      )),
    ]),
    backgroundColor: Colors.white,
    bottom: TabBar(
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).primaryColor,
      //indicator: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).primaryColor)),//color: Theme.of(context).primaryColor),
      labelStyle: TextStyle(
        color: Colors.grey,
        fontFamily: "nunito",
        fontSize: 18,
        fontWeight: FontWeight.w700
      ),
      tabs:<Widget>[
        Tab(text: "Chat"), //icon: Icon(Icons.chat),),
        Tab(text: "Profile"), //icon: Icon(Icons.person),),
      ] 
    ),
  );
}
