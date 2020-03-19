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

Widget buildChatProfileAppBar(String name, String imagePath) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleSpacing: 60,
    title: Row(children: <Widget>[
      CircleAvatar(
        radius: 18,
        backgroundImage: AssetImage(imagePath),
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
      labelColor: Colors.teal,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.teal,
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
