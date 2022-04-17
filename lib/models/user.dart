import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class User {
  String name;
  int number;
  String email;
  String description;

  User(
      {required this.name,
      required this.number,
      required this.email,
      required this.description});

  get getName => name;
  get getNumber => number;
  get getEmail => email;
  get getDescription => description;

  void changeName(String userName) {
    name = userName;
  }
  
  void changeNumber(int userNumber){
    number = userNumber; 
  }

  void changeDescription(String userDescription) {
    description = userDescription;
  }
}
