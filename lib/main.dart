import 'package:flutter/material.dart';
import 'package:hello_fluter/models/user.dart';
import 'package:hello_fluter/screens/messages.dart';
import 'package:hello_fluter/screens/wrapper.dart';
import 'package:hello_fluter/services/auth.dart';
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
// Scaffold(
//     body: PageView(
//         controller: _pageController,
//         children: <Widget>[
//           MessageView(),
//           SparkStatefulWidget(),
//         ],
//         onPageChanged: (index) {
//           setState( () {
//             _currentIndex = index;
//             });
//         }),
//     bottomNavigationBar: BottomNavigationBar(
//       currentIndex: _currentIndex,
//       selectedItemColor: Color.fromRGBO(215, 2, 101, 1),
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           title: Text("Home", style: TextStyle(fontFamily: "Nunito", color: Colors.black)),
//         ),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             title:
//                 Text("Chats", style: TextStyle(fontFamily: "Nunito", color: Colors.black)))
//       ],
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//           _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
//         });
//       },
//           ),
//     );
//   }
// }
