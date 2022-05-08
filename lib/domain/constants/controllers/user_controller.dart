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
<<<<<<< Updated upstream
  AuthenticationController authController = Get.find();
  RxList<User> usersList = RxList<User>([]);
  get users => usersList;
  RxList<User> friendsList = RxList<User>([]);
  get friendsl => friendsList;
=======
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  RxList<User> usersList = RxList<User>([]);
  get users => usersList;
>>>>>>> Stashed changes

  //Usuario
  late Rx<User> user = User(
          name: '',
          number: '123',
          email: '',
          description: '',
          latitude: '',
          longitude: '',
<<<<<<< Updated upstream
          id: '',
          friends: [])
=======
          id: '')
>>>>>>> Stashed changes
      .obs;

  UserController() {
    createUser();
    findusers();
<<<<<<< Updated upstream
    findfriends();
    print("correo actual " + authController.auth.currentUser!.email!);
=======
    print("correo actual " + authenticationController.auth.currentUser!.email!);
>>>>>>> Stashed changes
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
  Future<void> changeUserName(String userName) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'name': userName});
    user.value.changeName(userName);
  }

  //Función para cambiar el número
  Future<void> changeUserNumber(String userNumber) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'number': userNumber});
    user.value.changeNumber(userNumber);
  }

  //Función para cambiar la descripción
  Future<void> changeUserDescription(String userDescription) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'description': userDescription});
    user.value.changeDescription(userDescription);
  }

  void createUser() async {
    var query = userFirebase.where('email',
        isEqualTo: authController.auth.currentUser!.email);
    QuerySnapshot usuario = await query.get();
    String nombre = usuario.docs[0]['name'];
    String numero = usuario.docs[0]['number'];
    String descripcion = usuario.docs[0]['description'];
    String latitude = usuario.docs[0]['latitude'];
    String longitude = usuario.docs[0]['longitude'];
    String id = usuario.docs[0]['id'];
    List<dynamic> friends = usuario.docs[0]['friends'];
    user = User(
            name: nombre,
            number: numero,
            email: authController.auth.currentUser!.email!,
            description: descripcion,
            latitude: latitude,
            longitude: longitude,
            id: id,
            friends: friends)
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
          .doc(user.value.id)
          .set({
        'latitude': _locationResult.latitude.toString(),
        'longitude': _locationResult.longitude.toString(),
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
          .doc(user.value.id)
          .set({
        'latitude': currentlocation.latitude.toString(),
        'longitude': currentlocation.longitude.toString(),
      }, SetOptions(merge: true));
    });
  }

  stopListeningLocation() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  void findusers() async {
    var query = userFirebase.where('email',
<<<<<<< Updated upstream
        isNotEqualTo: authController.auth.currentUser!.email!);
=======
        isNotEqualTo: authenticationController.auth.currentUser!.email!);
>>>>>>> Stashed changes
    QuerySnapshot usuario = await query.get();
    List<User> users = [];
    for (var user in usuario.docs) {
      final _users = User.fromDocumentSnapshot(documentSnapshot: user);
      users.add(_users);
    }
    usersList = users.obs;
  }
<<<<<<< Updated upstream

  void findfriends() async {
    var query =
        userFirebase.where('email', isEqualTo: authController.auth.currentUser!.email!);
    QuerySnapshot usuario = await query.get();
    List<dynamic> friendsMail =usuario.docs[0]['friends'];
    List<User> friendss = [];
    for(var friend in friendsMail){
      var query = userFirebase.where('id',
        isEqualTo: friend);
    QuerySnapshot usuario = await query.get();
    String nombre = usuario.docs[0]['name'];
    String numero = usuario.docs[0]['number'];
    String email = usuario.docs[0]['email'];
    String descripcion = usuario.docs[0]['description'];
    String latitude = usuario.docs[0]['latitude'];
    String longitude = usuario.docs[0]['longitude'];
    String id = usuario.docs[0]['id'];
    List<dynamic> friends =usuario.docs[0]['friends'];
    User friendd = User(
            name: nombre,
            number: numero,
            email: email,
            description: descripcion,
            latitude: latitude,
            longitude: longitude,
            id: id,
            friends:friends);
    friendss.add(friendd);
    }
    friendsList = friendss.obs;
    
  }
=======
>>>>>>> Stashed changes
}
