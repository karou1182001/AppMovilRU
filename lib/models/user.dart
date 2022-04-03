import 'package:get/get.dart';

class User {
  String name;
  String password;
  int number;
  String email;
  String description;

  User(
      {required this.name,
      required this.password,
      required this.number,
      required this.email,
      required this.description});

  get getName => name;
  get getPassword => password;
  get getNumber => number;
  get getEmail => email;
  get getDescription => description;

  void changeName(String userName) {
    name = userName;
  }
}
