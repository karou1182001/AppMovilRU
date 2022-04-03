import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class User {
  RxString name = 'David Ocampo'.obs;
  String password;
  int number;
  String email;
  String description;

  User(
      {required this.password,
      required this.number,
      required this.email,
      required this.description});

  get getName => name.value;
  get getPassword => password;
  get getNumber => number;
  get getEmail => email;
  get getDescription => description;

  void changeName(String userName) {
    name.value = userName;
  }
}
