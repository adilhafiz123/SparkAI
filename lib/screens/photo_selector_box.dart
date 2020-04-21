import 'dart:io';
import 'package:Spark/models/cloud_storage_result.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/services/cloud_storage_service.dart';
import 'package:Spark/services/user.dart';
import 'package:Spark/shared/loading.dart';
import 'package:Spark/utils/image_selector.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoSelectorBox extends StatefulWidget {
  bool isMain;
  String imageFileName;
  Map<String,String> imageNameUrlMap;

  PhotoSelectorBox(this.isMain, this.imageFileName, this.imageNameUrlMap) {
    if (this.imageNameUrlMap == null) {
      this.imageNameUrlMap = Map<String, String>();
    }
  }

  @override
  _PhotoSelectorBoxState createState() => _PhotoSelectorBoxState();
}

class _PhotoSelectorBoxState extends State<PhotoSelectorBox> {
  String _myUid;
  File _imageFile;
  String _imageUrl;

  Future<File> editImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Theme.of(context).primaryColor,
            cropFrameColor: Colors.white,
            cropFrameStrokeWidth: 5,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile == null) {
      throw Exception("CroppedFile returned from ImageCropper.cropImage was null");
    }
    return croppedFile;
  }

  Future<File> selectImage() async {
    var selectedImage = await ImageSelector.selectImage();
    if (selectedImage != null) {
      File croppedImage = await editImage(selectedImage);
      _imageFile = croppedImage;
      return _imageFile;
    }
    throw Exception("Null object returned from ImageSelector widget");
  }

  Future<CloudStorageResult> storeImage() async {
    CloudStorageResult result = await CloudStorageService.uploadImage(_imageFile, widget.imageFileName);

    // If storage was successful then add the url to the database
    if (result != null) {
      widget.imageNameUrlMap[widget.imageFileName] = result.imageUrl;
      UserService(uid: _myUid).updateImageNameUrlMap(widget.imageNameUrlMap);
      _imageUrl = result.imageUrl;
    }
    else {
      throw Exception("Null object returned from CloudStorageService.uploadImage");
    }

    return result;
  }

  _selectAndStoreImage() {
    selectImage().then((tempImage) {
      if (tempImage != null) {
        storeImage().then((result) {
          if (result != null) {
            setState(() {
              _imageUrl = result.imageUrl; //TODO: Isnt this a repeat logic?
            });
          }
        });
      }
    });
  }

  _deleteImage() {
    CloudStorageService.deleteImage(widget.imageFileName).then( (_) {
      setState(() {
        widget.imageNameUrlMap.remove(widget.imageFileName);
        UserService(uid: _myUid).updateImageNameUrlMap(widget.imageNameUrlMap);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _myUid = Provider.of<User>(context).uid;
    _imageUrl = widget.imageNameUrlMap != null ? widget.imageNameUrlMap[widget.imageFileName] : null;
    var isAdd = (_imageUrl == null || _imageUrl.isEmpty);

    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(5),
        child: GestureDetector(
          child: DottedBorder(
            color:
                isAdd ? Color.fromRGBO(225, 238, 245, 1) : Colors.transparent,
            strokeWidth: 3,
            strokeCap: StrokeCap.butt,
            dashPattern: [10, 3],
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: widget.isMain 
                      ? Theme.of(context).accentColor.withOpacity(0.1) 
                      : Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              constraints: BoxConstraints.expand(width: 100, height: 100),
              child: isAdd
                  ? Center(
                      child: Image.asset(
                      "icons/add.png",
                      height: 26,
                      color: Colors.grey[400], //Theme.of(context).primaryColor,
                    ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: _imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          placeholder: (context, url) => Loading(),
                          errorWidget: (context, url, error) {
                            _imageUrl = null;
                            return Center(child: Icon(Icons.error));
                          }),
                    ),
            ),
          ),
          onTap: () {
            _selectAndStoreImage();
          },
        ),
      ),
      if (!isAdd)
        Positioned(
          bottom: -6,
          right: -27,
          child: ButtonTheme(
            height: 25,
            child: RaisedButton(
              elevation: 2,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.remove, size: 24, color: Colors.white,),
              ),
              shape: CircleBorder(side: BorderSide.none),
              onPressed: () {
                if (!isAdd) {
                  _deleteImage();
                }
              },
            ),
          ),
        ),
    ]);
  }
}
