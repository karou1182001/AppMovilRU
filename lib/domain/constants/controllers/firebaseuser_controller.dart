import 'dart:async';

import 'package:app_ru/domain/constants/constants/firabase_constants.dart';
import 'package:app_ru/models/users.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../constants/storage_repo.dart';
import 'authentication_controller.dart';
import 'package:location/location.dart' as loc;

class FirebaseUserController extends GetxController {
  AuthenticationController authController = Get.find();
  //Firestore
  CollectionReference userf = userFirebase;
  //Stream para obtener los datos de firebase
  final Stream<QuerySnapshot> _userStream = userFirebase.snapshots();
  late StreamSubscription<Object?> streamSubscription;
  final RxList<dynamic> _userList = RxList<Users>([]);
  final RxList<dynamic> _friendListofUser = RxList<Users>([]);
  final RxList<dynamic> _friendRequestListofUser = RxList<Users>([]);
  late Users actualUser;
  bool loaded = false;

  @override
  void onInit() {
    super.onInit();
    subscribeUpdates();
    print("on init");
  }

  //Getters
  get allUsers => _userList;
  get friendsOfUser => _friendListofUser;
  get friendsRequestOfUser => _friendRequestListofUser;

  // variables de localizacion
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  subscribeUpdates() async {
    //Actualiza todos los usuarios
    streamSubscription = _userStream.listen((user) {
      actualUser = Users.fromSnapshot(user.docs.singleWhere((element) =>
          element['id'] == authController.auth.currentUser!.email));
      List friends = actualUser.friends;
      List friendsRequest = actualUser.friendsRequest;
      List friendsRequested = actualUser.friendsRequested;
      _friendListofUser.clear();
      _userList.clear();
      _friendRequestListofUser.clear();
      user.docs.forEach((element) {
        if (element['id'] != authController.auth.currentUser!.email &&
            !friends.contains((element)['id']) &&
            !friendsRequest.contains((element)['id']) &&
            !friendsRequested.contains((element)['id'])) {
          Users user = Users.fromSnapshot(element);
          _userList.add(user);
        }
        if (friends.contains((element)['id'])) {
          Users user = Users.fromSnapshot(element);
          user.setColor();
          _friendListofUser.add(user);
        }
        if (friendsRequest.contains((element)['id'])) {
          Users user = Users.fromSnapshot(element);
          _friendRequestListofUser.add(user);
        }
      });
    });
    loaded = true;
  }

  unsubscribeUpdates() {
    streamSubscription.cancel();
  }

  //Función que cambia el estado del switch en perfil
  Future<void> changeRU() async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'ru': !this.actualUser.ru});
    stablishLocation(!this.actualUser.ru);
  }

  //Función para que cambie el nombre
  Future<void> changeUserName(String userName) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'name': userName});
  }

  //Función para cambiar el número
  Future<void> changeUserNumber(String userNumber) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'number': userNumber});
  }

  //Función para cambiar la descripción
  Future<void> changeUserDescription(String userDescription) async {
    final doc = userFirebase.doc(authController.auth.currentUser!.email);
    await doc.update({'description': userDescription});
  }

  void changeProfilePicture(String filePath) async {
    StorageRepo storage = StorageRepo();
    await storage.uploadFile(filePath, actualUser.email);
    String imagePath = await storage.retrieveFile(actualUser.email);
    print('esta es la nueva imagen ' + imagePath);
    final doc = userFirebase.doc(actualUser.email);
    await doc.update({'url': imagePath});
  }

  void changeProfileSchedule(String filePath) async {
    StorageRepo storage = StorageRepo();
    await storage.uploadFileSchedule(filePath, actualUser.email);
    String imagePath = await storage.retrieveFileSchedule(actualUser.email);
    final doc = userFirebase.doc(actualUser.email);
    await doc.update({'urlSchedule': imagePath});
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
          .doc(actualUser.email)
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
          .doc(actualUser.email)
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

  static Stream<List<Users>> userStream() {
    return userFirebase.snapshots().map((QuerySnapshot query) {
      List<Users> users = [];
      for (var user in query.docs) {
        final _users = Users.fromSnapshot(user);
        users.add(_users);
      }
      print(users.length);
      return users;
    });
  }

  addFriend(String friendMail) {
    final friendRef = userf.doc(friendMail);
    friendRef.update({
      "friendsRequest":
          FieldValue.arrayUnion([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    userRef.update({
      "friendsRequested": FieldValue.arrayUnion([friendMail]),
    });
  }

  acceptFriend(String friendMail) async {
    final friendRef = userf.doc(friendMail);
    await friendRef.update({
      "friendsRequested":
          FieldValue.arrayRemove([authController.auth.currentUser!.email]),
      "friends":
          FieldValue.arrayUnion([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    await userRef.update({
      "friendsRequest": FieldValue.arrayRemove([friendMail]),
      "friends": FieldValue.arrayUnion([friendMail]),
    });
  }

  declineFriend(String friendMail) async {
    final friendRef = userf.doc(friendMail);
    await friendRef.update({
      "friendsRequested":
          FieldValue.arrayRemove([authController.auth.currentUser!.email]),
    });
    final userRef = userf.doc(authController.auth.currentUser!.email);
    await userRef.update({
      "friendsRequest": FieldValue.arrayRemove([friendMail]),
    });
  }
}
