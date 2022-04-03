import 'package:app_ru/models/user.dart';
import 'package:get/get.dart';

class UserController {
  //Usuario
  Rx<User> user = const User(
          name: 'David Ocampo',
          number: 123456789,
          password: 'ocampo123',
          email: 'davidocampo@uninorte.edu.co',
          description: 'Me gustan las clases de Salazar')
      .obs;

  //Indicador de si está en la U o no
  final RxBool _ru = false.obs; 

  //Getters
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
}
