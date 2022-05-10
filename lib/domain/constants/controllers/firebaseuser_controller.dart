import 'dart:async';

import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/models/user.dart';
import 'package:app_ru/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/storage_repo.dart';
import 'authentication_controller.dart';
import 'user_controller.dart';

class FirebaseUserController extends GetxController {
 AuthenticationController authController = Get.find();
  //Firestore
  CollectionReference userf = userFirebase;
  //Stream para obtener los datos de firebase
  final Stream<QuerySnapshot> _userStream = userFirebase.snapshots();
  late StreamSubscription<Object?> streamSubscription;
  UserController userController = Get.find();
  final _userList = <Users>[].obs;
  final _friendListofUser = <Users>[].obs;
  

  @override
  void onInit() {
    super.onInit();
    
    //Inicia actualizando los eventos del usuario
    subscribeUpdates();
    print("on init");
  }

  //Getters
  get allUsers => _userList;
  get friendsOfUser => _friendListofUser;
  

  

  subscribeUpdates() async {
    //Actualiza todos los usuarios
    streamSubscription = _userStream.listen((user) {
      Users actualUser;
      List friends = [];
      user.docs.forEach((element) {
        if(element['id']==userController.email){
          actualUser = Users.fromSnapshot(element);
          friends = actualUser.friends;
        }
      });
      _friendListofUser.clear();
      _userList.clear();
      user.docs.forEach((element) {
        if(element['id']!=userController.email){
          _userList.add(Users.fromSnapshot(element));
        }
        if(friends.contains((element)['id'])){
          _friendListofUser.add(Users.fromSnapshot(element));
        }
      });
      print("Got a total of ${_friendListofUser.length} friends");
      print("Got a total of ${_userList.length} users");
    });
  }

  unsubscribeUpdates() {
    streamSubscription.cancel();
  }



  static Stream<List<Users>> userStream() {
    return userFirebase.snapshots().map((QuerySnapshot query) {
      List<Users> users = [];
      for (var user in query.docs) {
        final _users = Users.fromSnapshot(user);
        users.add(_users);
      }
      print(users.length);
      return users;
    });
  }

 
}
