import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hakawati/core/errors/firebase_custom_exception.dart';
import 'package:hakawati/core/functions/logger.dart';
import 'package:hakawati/core/services/service_locator.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = sl.get<FirebaseStorage>();

// to replace the existing file
  Future<String> uploadFile(File file) async {
    try {
      TaskSnapshot taskSnapshot = await _firebaseStorage.ref('uploads/${file.path.split('/').last}').putFile(file);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleStorageError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<String> downloadFile(String remoteFilePath) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String localFilePath = '${appDocDir.path}/signed-users.xlsx';
    File downloadToFile = File(localFilePath);
    try {
      await _firebaseStorage.ref(remoteFilePath).writeToFile(downloadToFile);
      return downloadToFile.path;
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleStorageError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }
}
