import 'package:Spark/models/userData.dart';
import 'package:Spark/screens/photo_selector_box.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoSelector extends StatefulWidget {
  @override
  _PhotoSelectorState createState() => _PhotoSelectorState();
}

class _PhotoSelectorState extends State<PhotoSelector> {
  String _myUid;
  bool _blurPhotos = false;
  UserData _userData;

  _generateFileName(int index) {
    return _myUid  + "/" + index.toString() + ".jpg";
  }

  @override
  Widget build(BuildContext context) {   
    _myUid = Provider.of<User>(context).uid;
    _userData = Provider.of<UserData>(context);
     var imageNameUrlMap = _userData.imageNameUrlMap;    

    return Scaffold(
      appBar: buildAppBar("Edit Profile", List()),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
                children: <Widget>[
                  PhotoSelectorBox(true, _generateFileName(0), imageNameUrlMap),
                  PhotoSelectorBox(false, _generateFileName(1), imageNameUrlMap),
                  PhotoSelectorBox(false, _generateFileName(2), imageNameUrlMap),
                  PhotoSelectorBox(false, _generateFileName(3), imageNameUrlMap),
                  PhotoSelectorBox(false, _generateFileName(4), imageNameUrlMap),
                  PhotoSelectorBox(false, _generateFileName(5), imageNameUrlMap),
                  ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,0, 8,0),
            child: Row(
              children: <Widget>[
                Text("Blur photos?", style: TextStyle(fontFamily: "Nunito", fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(width: 130,),
                Switch(
                  value: _blurPhotos,                  
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    _blurPhotos = !_blurPhotos;
                    _userData.isBlurred = val;
                    UserService(uid:_myUid).updateCurrentUserData(_userData);
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 330,),
        ],
      ),
    );
  }
}
