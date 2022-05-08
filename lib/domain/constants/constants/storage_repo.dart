import 'dart:io';

import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageRepo {
  AuthenticationController authController = Get.find();
  final storage = FirebaseStorage.instance;
  Future<void> uploadFile(String filePath) async {
    String userId = authController.auth.currentUser!.uid;
    File file = File(filePath);
    try {
      await storage.ref().child('user/profile/$userId').putFile(file);
    } catch (e) {}
  }
}
