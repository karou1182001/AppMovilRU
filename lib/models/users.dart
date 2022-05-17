import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  DocumentReference userId;
  late String name;
 late  String number;
  late String email;
  late String description;
 late List friends;
late List friendsRequest;
 late List friendsRequested;

  Users.fromMap(Map<String, dynamic> map, {required this.userId})
      : assert(map['name'] != null),
        assert(map['number'] != null),
        assert(map['email'] != null),
        assert(map['description'] != null),
        assert(map['friends'] != null),
        assert(map['friendsRequest'] != null),
        assert(map['friendsRequested'] != null),
        name = map['name'],
        number = map['number'],
        email = map['email'],
        description = map['description'],
        friends = map['friends'],
        friendsRequest = map['friendsRequest'],
        friendsRequested = map['friendsRequested'];

  Users.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            userId: snapshot.reference);
}