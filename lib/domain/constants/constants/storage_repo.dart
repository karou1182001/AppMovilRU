import 'dart:io';

import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageRepo {
  AuthenticationController authController = Get.find();
  final storage = FirebaseStorage.instance;
  Future<void> uploadFile(String filePath) async {
    String? userEmail = authController.auth.currentUser!.email;
    File file = File(filePath);
    try {
      await storage.ref().child('user/$userEmail/profilePic').putFile(file);
    } catch (e) {}
  }

  Future<String> retrieveFile() async {
    String? userEmail = authController.auth.currentUser!.email;
    try {
      final ref = storage.ref().child('user/$userEmail/profilePic');
      var url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return '';
    }
  }
}
