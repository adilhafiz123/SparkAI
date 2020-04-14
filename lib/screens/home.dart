import 'package:Spark/screens/settings.dart';
import 'package:Spark/services/chats.dart';
import 'package:flutter/material.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/models/chat.dart';
import 'package:Spark/screens/discover.dart';
import 'package:Spark/screens/messages.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _tabs = [];

  @override
  void initState() {
    super.initState();

    _tabs.add(DiscoverView());
    _tabs.add(MessageView());
    _tabs.add(Settings());
  }

  @override
  Widget build(BuildContext context) {
    final myUid = Provider.of<User>(context).uid;
    TextStyle bnbStyle = TextStyle(fontFamily: "Nunito" , fontWeight: FontWeight.w700,);
    return MultiProvider(
      providers: [
        StreamProvider<List<Uid1Chat>>(create: (context) => ChatsService(myUid: myUid).getUID1Chats),
        StreamProvider<List<Uid2Chat>>(create: (context) => ChatsService(myUid: myUid).getUID2Chats),
      ],
      child: Scaffold(
          body: _tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "icons/swipe.png", 
                    width: 25,
                    color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey
                    ),
                  title: Text("Discover", style: bnbStyle),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "icons/chat.png", 
                    width: 25,
                    color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey
                    ),
                    title: Text("Messages",style: bnbStyle)
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                    "icons/settings.png", 
                    width: 25,
                    color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey
                    ),
                    title: Text("Settings",
                        style: bnbStyle)
                        )
              ],
              onTap: (index) {
                setState(() => _currentIndex = index);
              })),
    );
  }
}
