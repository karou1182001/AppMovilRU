import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String name;
 late  String number;
  late String email;
  late String description;
 late  String latitude;
 late  String longitude;
 late  String id;

  User(
      {required this.name,
      required this.number,
      required this.email,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.id,
      });

  get getName => name;
  get getNumber => number;
  get getEmail => email;
  get getDescription => description;

  void changeName(String userName) {
    name = userName;
  }
  
  void changeNumber(String userNumber){
    number = userNumber; 
  }

  void changeDescription(String userDescription) {
    description = userDescription;
  }

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    name = documentSnapshot['name'];
    number = documentSnapshot['number'];
    email = documentSnapshot['email'];
    description = documentSnapshot['description'];
    latitude = documentSnapshot['latitude'];
    longitude = documentSnapshot['longitude'];
    id = documentSnapshot['id'];
  }
}
