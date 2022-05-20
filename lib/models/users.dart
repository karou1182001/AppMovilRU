import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  String url ='https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg';
  String urlSchedule = 'https://i.pinimg.com/originals/36/1c/73/361c7372f6113e6dfb5c28f6f03194ee.png';
Future<void> getProfileUrl() async {
    StorageRepo storage = StorageRepo();
    url = await storage.retrieveFile(email); 
    if(url==""){
      url ='https://www.meteorologiaenred.com/wp-content/uploads/2018/02/olas.jpg';
    }
    print('Soy la URL: ${url}');
  }
  Future<void> getScheduleUrl() async {
    StorageRepo storage = StorageRepo();
    urlSchedule = await storage.retrieveFileSchedule(email);
    if(urlSchedule == ''){
      urlSchedule = 'https://i.pinimg.com/originals/36/1c/73/361c7372f6113e6dfb5c28f6f03194ee.png';
    }
    print('Soy la URL: ${url}');
  }
void init(){
  getProfileUrl();
  getScheduleUrl();
}

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