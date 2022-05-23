import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/constants/constants/storage_repo.dart';

class Users {
  DocumentReference userId;
  late String name;
  late  String number;
  late String email;
  late String description;
 late List friends;
  late List friendsRequest;
 late List friendsRequested;
 late bool ru;
 late Color color = Colors.red;
  late String url ;
  late String urlSchedule;

  void setColor()async{
    if(ru){
      color = Colors.green;
    }else{
      color = Colors.red;
    }
}
void init()async{
 
}

  Users.fromMap(Map<String, dynamic> map, {required this.userId})
      : assert(map['name'] != null),
        assert(map['number'] != null),
        assert(map['email'] != null),
        assert(map['description'] != null),
        assert(map['friends'] != null),
        assert(map['friendsRequest'] != null),
        assert(map['friendsRequested'] != null),
        assert(map['ru'] != null),
        assert(map['url'] != null),
        assert(map['urlSchedule'] != null),
        name = map['name'],
        number = map['number'],
        email = map['email'],
        description = map['description'],
        friends = map['friends'],
        friendsRequest = map['friendsRequest'],
        friendsRequested = map['friendsRequested'],
        ru = map['ru'],
        url = map['url'],
        urlSchedule = map['urlSchedule'];

  Users.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            userId: snapshot.reference);
  
}