import 'dart:async';

import 'package:app_ru/domain/constants/controllers/authentication_controller.dart';
import 'package:app_ru/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../constants/firabase_constants.dart';

class UserController extends GetxController {
  AuthenticationController authenticationController = Get.find();
  //Usuario
  late Rx<User> user =
      User(name: '', number: 123, email: '', description: '').obs;

  UserController() {
    createUser();
  }

  //Indicador de si está en la U o no
  final RxBool _ru = false.obs;

  // variables de localizacion
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  //Getters
  User get getUser => user.value;
  get email => user.value.getEmail;
  get name => user.value.getName;
  get number => user.value.getNumber;
  get ru => _ru.value;
  get description => user.value.getDescription;

  //Función que cambia el estado del switch en perfil
  void changeRU() {
    _ru.value = !_ru.value;
    stablishLocation(_ru.value);
  }

  //Función para que cambie el nombre
  void changeUserName(String userName) {
    user.value.changeName(userName);
  }

  //Función para cambiar el número
  void changeUserNumber(int userNumber) {
    user.value.changeNumber(userNumber);
  }

  //Función para cambiar la descripción
  void changeUserDescription(String userDescription) {
    user.value.changeDescription(userDescription);
  }

  void createUser() async {
    var query = userFirebase.where('email',
        isEqualTo: authenticationController.auth.currentUser!.email);
    QuerySnapshot usuario = await query.get();
    String nombre = usuario.docs[0]['name'];
    int numero = int.parse(usuario.docs[0]['number']);
    String descripcion = usuario.docs[0]['description'];
    user = User(
            name: nombre,
            number: numero,
            email: authenticationController.auth.currentUser!.email!,
            description: descripcion)
        .obs;
  }

//Parte de geolocalización
  void stablishLocation(bool value) {
    if (value == true) {
      getLocation();
      listenLocation();
    } else {
      stopListeningLocation();
    }
  }

  void getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('usuario')
          .doc('AeKKTBW9zN2z2c9nDUAj')
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      _locationSubscription = null;
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('usuario')
          .doc('AeKKTBW9zN2z2c9nDUAj')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
      }, SetOptions(merge: true));
    });
  }

  stopListeningLocation() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}
