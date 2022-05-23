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
  final RxList<dynamic> _userList = RxList<Users>([]);
  final RxList<dynamic> _friendListofUser = RxList<Users>([]);
  final RxList<dynamic> _friendRequestListofUser = RxList<Users>([]);
  

  @override
  void onInit()  {
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
     streamSubscription =  _userStream.listen((user) {
      Users actualUser = Users.fromSnapshot(user.docs.singleWhere((element) => element['id']==authController.auth.currentUser!.email));
      List friends =  actualUser.friends;
      List friendsRequest = actualUser.friendsRequest;
      List friendsRequested = actualUser.friendsRequested;
      _friendListofUser.clear();
      _userList.clear();
      _friendRequestListofUser.clear();
      user.docs.forEach((element) {
        if(element['id']!=authController.auth.currentUser!.email && !friends.contains((element)['id']) && !friendsRequest.contains((element)['id']) && !friendsRequested.contains((element)['id'])){
          Users user = Users.fromSnapshot(element);
          user.getProfileUrl();
          _userList.add(user);
        }
        if(friends.contains((element)['id'])){
          Users user = Users.fromSnapshot(element);
          user.getProfileUrl();
          user.getScheduleUrl();
          user.setColor();
          _friendListofUser.add(user);
        }
        if(friendsRequest.contains((element)['id'])){
          Users user = Users.fromSnapshot(element);
          user.getProfileUrl();
          _friendRequestListofUser.add(user);
        }
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
