import 'package:flutter/material.dart';
import 'package:hello_fluter/models/userData.dart';
import 'package:hello_fluter/screens/chat_profile.dart';
import 'package:hello_fluter/services/auth.dart';
import 'package:provider/provider.dart';

class MessageTab extends StatelessWidget {
  String imagePath;
  String firstName;
  String lastMsg;
  String profession;

  MessageTab(UserData userData)
  {
     imagePath  = "images/mawra.jpg";
     firstName  = userData.firstname;
     lastMsg    = "Hi! How are you?";
     profession = userData.profession;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatProfile(
                    image: imagePath,
                    name: firstName,
                  ))),
      child: Row(children: <Widget>[
        SizedBox(width: 16),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(firstName,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 15),
                Text(profession,
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(169, 176, 182, 1),
                        fontFamily: 'Nunito')),
              ],
            ),
            Text(lastMsg,
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(85, 99, 110, 1),
                    fontFamily: 'Nunito')),
            Text("1 minute ago",
                style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(171, 176, 180, 1),
                    fontFamily: 'Nunito'))
          ],
        )
      ]),
    );
  }
}

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    
    final _userDataList = Provider.of<List<UserData>>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          titleSpacing: 60,
          title: Text("Messages"),
          leading: Image(
            image: AssetImage("images/sparks.png"),
            //height: 70,
            //width: 70,
            color: Colors.white,
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                  color: Colors.grey[100],
                  shape: StadiumBorder(),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Text("Sign Out")),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: _userDataList.length,
          itemBuilder: (BuildContext context, int index) {
           return MessageTab(_userDataList[index]);
          },


        // body: ListView (
        //   children: <Widget>[
        //     Row(
        //       children: <Widget>[
        //         Spacer(),
        //         Spacer(),
        //       ],
        //     ),
        //     SizedBox(height: 15,),
        //     Row(
        //       children: <Widget>[
        //         Spacer(),
        //         Text("Your Chats",
        //             style: TextStyle(fontSize: 36, fontFamily: 'Vidaloka')),
        //         Spacer()
        //       ],
        //     ),
        //     SizedBox(
        //       height: 6,
        //     ),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/mawra.jpg", "Mawra", "Hello! How are you?", "Actress"),
        //     Divider(color: Colors.black38),
        //     MessageTab(
        //         "images/profilepic.png", "Bluey", "Where are you Adil?", "UCL"),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/mawra.jpg", "Sana", "Hey, you ok?", "Optomotrist"),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/profilepic.png", "Areeba", "Hello! How are you?",
        //         "Lawyer"),
        //     Divider(color: Colors.black38),
        //     MessageTab(
        //         "images/mawra.jpg", "Hareem", "Hello! How are you?", "Actress"),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/profilepic.png", "Saba", "Hello! How are you?",
        //         "Pharmacist"),
        //     Divider(color: Colors.black38),
        //     MessageTab(
        //         "images/mawra.jpg", "Samina", "Hello! How are you?", "Actress"),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/profilepic.png", "Ameena", "Hello! How are you?",
        //         "Doctor"),
        //     Divider(color: Colors.black38),
        //     MessageTab(
        //         "images/mawra.jpg", "Ayesha", "Hello! How are you?", "Actress"),
        //     Divider(color: Colors.black38),
        //     MessageTab("images/profilepic.png", "Faiza", "Hello! How are you?",
        //         "Teacher"),
        //     Divider(color: Colors.black38),
        //   ]
        // )
      )
    );
  }
}
