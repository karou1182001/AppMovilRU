import 'package:app_ru/models/user.dart';
import 'package:get/get.dart';

class UserController {
  Rx<User> user = const User(
          name: 'David Ocampo',
          number: 123456789,
          password: 'ocampo123',
          email: 'davidocampo@uninorte.edu.co')
      .obs;

  //Getters
  get email => user.value.getEmail;
  get name => user.value.getName;
  get password => user.value.getPassword;
  get number => user.value.getNumber;
}
