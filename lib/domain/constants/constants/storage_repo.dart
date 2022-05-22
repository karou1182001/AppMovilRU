import 'dart:io';

import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageRepo {
  AuthenticationController authController = Get.find();
  final storage = FirebaseStorage.instance;

  //Imagenes del perfil de usuario
  Future<void> uploadFile(String filePath, String mail) async {
    String? userEmail = mail;
    File file = File(filePath);
    try {
      await storage.ref().child('user/$userEmail/profilePic').putFile(file);
    } catch (e) {}
  }

  Future<void> uploadFileSchedule(String filePath, String mail) async {
    String? userEmail = mail;
    File file = File(filePath);
    try {
      await storage.ref().child('user/$userEmail/schedule').putFile(file);
    } catch (e) {}
  }

  Future<String> retrieveFile(String mail) async {
    String? userEmail = mail;
    try {
      final ref = storage.ref().child('user/$userEmail/profilePic');
      var url = await ref.getDownloadURL();
      print('Esta es la ' + url);
      return url;
    } catch (e) {
      return '';
    }
  }

  Future<String> retrieveFileSchedule(String mail) async {
    String? userEmail = mail;
    try {
      final ref = storage.ref().child('user/$userEmail/schedule');
      var url = await ref.getDownloadURL();
      print('Esta es la ' + url);
      return url;
    } catch (e) {
      return '';
    }
  }

  //Imagen de cada evento
  Future<void> uploadFileEvent(String filePath, String eventId) async {
    File file = File(filePath);
    try {
      await storage.ref().child('event/$eventId/eventPic').putFile(file);
    } catch (e) {
      print("No se subió");
    }
  }

  Future<String> retrieveFileEvent(String eventId) async {
    try {
      final ref = storage.ref().child('event/$eventId/eventPic');
      var url = await ref.getDownloadURL();
      print('Esta es la ' + url);
      return url;
    } catch (e) {
      return '';
    }
  }
}
