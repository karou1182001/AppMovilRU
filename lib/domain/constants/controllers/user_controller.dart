import 'package:app_ru/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserController extends GetxController {
  //Usuario
  Rx<User> user = User(
          name: 'David Ocampo',
          number: 123456789,
          password: 'ocampo123',
          email: 'davidocampo@uninorte.edu.co',
          description: 'Me gustan las clases de Salazar')
      .obs;

  //Indicador de si está en la U o no
  final RxBool _ru = false.obs;

  //Getters
  User get getUser => user.value;
  get email => user.value.getEmail;
  get name => user.value.getName;
  get password => user.value.getPassword;
  get number => user.value.getNumber;
  get ru => _ru.value;
  get description => user.value.getDescription;

  //Función que cambia el estado del switch en perfil
  void changeRU() {
    _ru.value = !_ru.value;
  }

  //Función para que cambie el nombre
  void changeUserName(String userName) {
    user.value.changeName(userName);
  }

  //Función para cambiar la contraseña
  void changeUserPassword(String userPassword) {
    user.value.changePassword(userPassword);
  }

  //Función para cambiar el número
  void changeUserNumber(int userNumber) {
    user.value.changeNumber(userNumber);
  }

  //Función para cambiar la descripción
  void changeUserDescription(String userDescription) {
    user.value.changeDescription(userDescription);
  }

}
