import 'dart:async';

import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/event.dart';
import 'package:app_ru/models/user.dart';
import 'package:app_ru/models/users.dart';
import 'package:app_ru/ui/pages/pageFriends/friends.dart';
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
  final _friendRequestListofUser = <Users>[].obs;
  

  @override
  void onInit() {
    super.onInit();
    subscribeUpdates();
    print("on init");
  }

  //Getters
  get allUsers => _userList;
  get friendsOfUser => _friendListofUser;
  get friendsRequestOfUser => _friendRequestListofUser;
  

  subscribeUpdates() async {
    //Actualiza todos los usuarios
    streamSubscription = _userStream.listen((user) {
      Users actualUser;
      List friends = [];
      List friendsRequest = [];
      List friendsRequested = [];
      user.docs.forEach((element) {
        if(element['id']==authController.auth.currentUser!.email){
          actualUser = Users.fromSnapshot(element);
          friends = actualUser.friends;
          friendsRequest = actualUser.friendsRequest;
          friendsRequested = actualUser.friendsRequested;
          print('hola si encontre mi usuario');
        }
      });
      _friendListofUser.clear();
      _userList.clear();
      _friendRequestListofUser.clear();
      user.docs.forEach((element) {
        if(element['id']!=authController.auth.currentUser!.email && !friends.contains((element)['id']) && !friendsRequest.contains((element)['id']) && !friendsRequested.contains((element)['id'])){
          _userList.add(Users.fromSnapshot(element));
        }
        if(friends.contains((element)['id'])){
          _friendListofUser.add(Users.fromSnapshot(element));
        }
        if(friendsRequest.contains((element)['id'])){
          _friendRequestListofUser.add(Users.fromSnapshot(element));
        }
      });
      print("Got a total of ${_friendListofUser.length} friends");
      print("Got a total of ${_userList.length} users");
      print("Got a total of ${_friendRequestListofUser.length} friends Request");
      _friendListofUser.forEach((friend) {
          friend.getProfileUrl();
          friend.getScheduleUrl();
      });
      _userList.forEach((user) {
          user.getProfileUrl();
          user.getScheduleUrl();
      });
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

  addFriend(String friendMail){
    final friendRef = userf.doc(friendMail);
    friendRef.update({
      "friendsRequest": FieldValue.arrayUnion([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    userRef.update({
      "friendsRequested": FieldValue.arrayUnion([friendMail]),
    });

  }

  acceptFriend(String friendMail)async {
    final friendRef = userf.doc(friendMail);
    await friendRef.update({
      "friendsRequested": FieldValue.arrayRemove([authController.auth.currentUser!.email]),
      "friends": FieldValue.arrayUnion([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    await userRef.update({
      "friendsRequest": FieldValue.arrayRemove([friendMail]),
      "friends": FieldValue.arrayUnion([friendMail]),
    });

  }

  declineFriend(String friendMail)async {
    final friendRef = userf.doc(friendMail);
    await friendRef.update({
      "friendsRequested": FieldValue.arrayRemove([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    await userRef.update({
      "friendsRequest": FieldValue.arrayRemove([friendMail]),
    });

  }

 
}
