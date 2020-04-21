import 'dart:io';

import 'package:Spark/models/cloud_storage_result.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CloudStorageService {
  static Future deleteImage(String imageNameToDelete) async {
    final StorageReference reference =
        FirebaseStorage.instance.ref().child(imageNameToDelete);

    try {
      return reference.delete();
    } catch (e) {
      return null;
    }
  }

  static Future<CloudStorageResult> uploadImage(File imageToUpload, String imageFileName) async {
    final StorageReference reference =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = reference.putFile(imageToUpload);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var urlFuture = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = urlFuture.toString();
      return CloudStorageResult(imageFileName: imageFileName, imageUrl: url);
    }

    return null;
  }
}
