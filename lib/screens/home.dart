import 'package:flutter/material.dart';
import 'package:hello_fluter/models/userData.dart';
import 'package:hello_fluter/screens/messages.dart';
import 'package:hello_fluter/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().userStream,
      child: Scaffold(
        body:
            MessageView(), //This will be a tab view eventually with MEssages being just one of the tabs!
      ),
    );
  }
}

// class _HomeState extends State<Home> {
//   String text = "SOME INITIAL TEXT";
//   final colors = ["Sunni", "Shia", "Other"];
//   String color = "Sunni";
//   Color buttonColor = Colors.deepPurple;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: <Widget>[
//         //SparkImageWidget(),
//         SparkImageWidget(),
//         Spacer(),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.headline,
//           // style: TextStyle(
//           //     fontSize: 30,
//           //     fontFamily: 'Nunito',
//           //     fontWeight: FontWeight.bold),
//         ),
//         Spacer(),
//         Container(
//             margin: EdgeInsets.all(12),
//             child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     hintText: "Jon Smith",
//                     hintStyle: TextStyle(fontStyle: FontStyle.italic),
//                     labelText: "Name"),
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.bold),
//                 onChanged: (String enteredText) {
//                   setState(() {
//                     text = "Welcome " + enteredText + "!";
//                   });
//                 })),
//         //Spacer(flex: 1,),
//         Container(
//             margin: EdgeInsets.all(12),
//             child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     hintText: "25",
//                     hintStyle: TextStyle(fontStyle: FontStyle.italic),
//                     labelText: "Age"),
//                 keyboardType: TextInputType.number,
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Nunito',
//                     fontWeight: FontWeight.bold),
//                 onChanged: (String enteredText) {
//                   return null;
//                 })),
//         Spacer(flex: 1),
//         Row(
//           children: <Widget>[
//             Spacer(),
//             Text("Sect", style: Theme.of(context).textTheme.headline),
//             Spacer(flex: 2),
//             DropdownButton<String>(
//               value: color,
//               items: colors.map((String value) {
//                 return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(fontSize: 30),
//                     ));
//               }).toList(),
//               onChanged: (String value) {
//                 setState(() {
//                   color = value;
//                 });
//               },
//             ),
//             Spacer(),
//           ],
//         ),
//         Spacer(flex: 3),
//         SparkButton(),
//         Spacer(flex: 2)
//       ]),
//     );
//   }
// }

// class SparkImageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     AssetImage sparkAsset = AssetImage('images/sparks.png');
//     Image image = Image(image: sparkAsset, width: 400, height: 150);
//     return Container(
//       child: image,
//     );
//   }
// }

// class SparkButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var button = Container(
//       child: RaisedButton(
//         child: Text(
//           'Save',
//           style: TextStyle(color: Colors.white, fontSize: 30),
//         ),
//         shape: StadiumBorder(),
//         color: Color.fromRGBO(215, 2, 101, 1),
//         padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
//         elevation: 5.0,
//         onPressed: () {
//           showSparkDialog(context);
//         },
//       ),
//     );
//     return button;
//   }

//   void showSparkDialog(BuildContext context) {
//     var alertDialog = AlertDialog(
//       title: Text(
//         "It's a Spark!",
//         style: TextStyle(color: Colors.white),
//       ),
//       content: Text(
//         "You have matched with a member.",
//         style: TextStyle(color: Colors.white),
//       ),
//       backgroundColor: Colors.teal,
//     );
//     showDialog(
//         context: context, builder: (BuildContext context) => alertDialog);
//   }
// }
